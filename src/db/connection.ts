import dotenv from 'dotenv';
dotenv.config();
import { Pool } from 'pg';

const pool = new Pool({
  connectionString: process.env.DATABASE_URL
});

pool.on('error', err => console.error('Unexpected PG error', err));

export default pool;
