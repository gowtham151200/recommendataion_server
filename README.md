## Quick start

1. Copy `.env.example` to `.env` and set DATABASE_URL.
2. Create database and run `sql/schema.sql` and `sql/seed_data.sql` (if present).
3. Install:
   ```
   npm install
   ```
4  npm run build
   ```
   npm start
   ```
   npx @modelcontextprotocol/inspector

Tools available via MCP stdio:
- search_products
- get_product_details
- get_user_history
- get_recommendations
- record_interaction
