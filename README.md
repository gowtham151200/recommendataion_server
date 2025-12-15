 # Recommendation Server
        I have built a Product Recommendation System using Model Context Protocol (MCP), Node.js (TypeScript), and PostgreSQL. The project exposes an MCP server that allows AI agents to interact with a structured product database through well-defined tools.

The system supports product search, user interaction tracking (views, purchases, wishlists), and personalized product recommendations. A content-based recommendation algorithm analyzes user interaction history to identify preferred categories and brands, and suggests relevant products while excluding already interacted items.

The project includes a properly designed PostgreSQL schema, seeded sample data, clean TypeScript code, and complete MCP tool implementations. All tools were tested using an MCP-compatible client to ensure correctness and reliability.

This project demonstrates my understanding of backend development, database design, MCP server implementation, and basic recommendation system logic.

# Install Dependencies 
    npm install
# Setup PostgreSQL Database
    CREATE DATABASE recommendation_db;
# Run the Project
     npm run build
     npm start
     npx @modelcontextprotocol/inspector

# Tools avaliable via MCP stdio
     search_products
     get_product_details
     get_user_history
     get_recommenations
     record_interaction
