import { z } from 'zod';
import pool from '../db/connection.js';
import type { Product } from '../types/index.js';

export const getRecommendationsSchema = z.object({
  user_id: z.string().uuid(),
  limit: z.number().int().positive().optional().default(5)
});

export async function getRecommendations(args: unknown) {
  const { user_id, limit } = getRecommendationsSchema.parse(args);

  const history = await pool.query(
    `SELECT p.category, p.brand,
       SUM(CASE WHEN interaction_type='purchase' THEN 5
                WHEN interaction_type='wishlist' THEN 3
                ELSE 1 END) as score
     FROM user_interactions ui
     JOIN products p ON p.product_id=ui.product_id
     WHERE ui.user_id=$1
     GROUP BY p.category, p.brand
     ORDER BY score DESC`,
    [user_id]
  );

  const categories = [...new Set(history.rows.map((r:any)=>r.category))].filter(Boolean);
  const brands = [...new Set(history.rows.map((r:any)=>r.brand))].filter(Boolean);

  let sql = `SELECT p.*, (CASE WHEN p.brand = ANY($1) THEN 1 ELSE 0 END) as brand_match
             FROM products p
             WHERE p.is_active=true
             AND p.product_id NOT IN (SELECT product_id FROM user_interactions WHERE user_id=$2)`;
  const params:any[] = [brands, user_id];

  if(categories.length>0){
    sql += ` AND p.category = ANY($3)`;
    params.push(categories);
  } else {
    params.push([]); // placeholder
  }

  sql += ` ORDER BY brand_match DESC, p.created_at DESC LIMIT $4`;
  params.push(limit);

  const res = await pool.query(sql, params);
  let recs = res.rows as Product[];

  if(recs.length < limit){
    const need = limit - recs.length;
    const more = await pool.query(
      `SELECT * FROM products p
       WHERE p.is_active = true
       AND p.product_id NOT IN (SELECT product_id FROM user_interactions WHERE user_id = $1)
       ORDER BY p.created_at DESC
       LIMIT $2`,
      [user_id, need]
    );
    recs = recs.concat(more.rows);
  }

  return { recommendations: recs.slice(0, limit) };
}
