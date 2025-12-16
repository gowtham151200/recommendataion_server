import { z } from 'zod';
import pool from '../db/connection.js';

export const getUserHistorySchema = z.object({
  user_id: z.string().uuid(),
  limit: z.number().int().positive().optional().default(20)
});

export async function getUserHistory(args: unknown){
  const { user_id, limit } = getUserHistorySchema.parse(args);
  const res = await pool.query(
    `SELECT ui.*, p.name as product_name, p.category, p.brand
     FROM user_interactions ui
     JOIN products p ON p.product_id = ui.product_id
     WHERE ui.user_id=$1
     ORDER BY created_at DESC
     LIMIT $2`,
    [user_id, limit]
  );
  return { history: res.rows };
}

export const recordInteractionSchema = z.object({
  user_id: z.string().uuid(),
  product_id: z.string().uuid(),
  interaction_type: z.enum(['view','purchase','wishlist'])
});

export async function recordInteraction(args: unknown){
  const { user_id, product_id, interaction_type } = recordInteractionSchema.parse(args);
  const res = await pool.query(
    `INSERT INTO user_interactions (user_id,product_id,interaction_type)
     VALUES ($1,$2,$3) RETURNING *`,
    [user_id, product_id, interaction_type]
  );
  return { interaction: res.rows[0] };
}
