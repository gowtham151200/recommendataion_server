import { z } from 'zod';
import pool from '../db/connection.js';
import type { Product } from '../types/index.js';

export const searchProductsSchema = z.object({
  query: z.string().min(1),
  category: z.string().optional(),
  brand: z.string().optional(),
  limit: z.number().int().positive().optional().default(10)
});

export async function searchProducts(args: unknown) {
  const parsed = searchProductsSchema.parse(args);
  const { query, category, brand, limit } = parsed;

  let baseSQL = `SELECT * FROM products WHERE is_active = true`;
  const values:any[] = [];
  let i=1;

  if(query){
    baseSQL += ` AND (name ILIKE $${i} OR description ILIKE $${i})`;
    values.push(`%${query}%`); i++;
  }
  if(category){
    baseSQL += ` AND category = $${i}`;
    values.push(category); i++;
  }
  if(brand){
    baseSQL += ` AND brand = $${i}`;
    values.push(brand); i++;
  }

  baseSQL += ` ORDER BY created_at DESC LIMIT $${i}`;
  values.push(limit);

  const res = await pool.query(baseSQL, values);
  return { results: res.rows as Product[] };
}

export const getProductDetailsSchema = z.object({
  product_id: z.string().uuid()
});

export async function getProductDetails(args: unknown){
  const { product_id } = getProductDetailsSchema.parse(args);
  const res = await pool.query(`SELECT * FROM products WHERE product_id=$1`,[product_id]);
  if(res.rows.length===0) throw new Error("Product not found");
  return { product: res.rows[0] as Product };
}
