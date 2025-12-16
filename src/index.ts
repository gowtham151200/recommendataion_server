import dotenv from "dotenv";
dotenv.config();

import { zodToJsonSchema } from "zod-to-json-schema";

import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";

import {
  searchProducts,
  getProductDetails,
  searchProductsSchema,
  getProductDetailsSchema,
} from "./tools/products.js";

import {
  getUserHistory,
  recordInteraction,
  getUserHistorySchema,
  recordInteractionSchema,
} from "./tools/history.js";

import {
  getRecommendations,
  getRecommendationsSchema,
} from "./tools/recommendations.js";

import pool from "./db/connection.js";

/* -------------------- Schema Conversion -------------------- */

const searchProductsJsonSchema = zodToJsonSchema(searchProductsSchema, {
  target: "jsonSchema7",
});
const getProductDetailsJsonSchema = zodToJsonSchema(
  getProductDetailsSchema,
  { target: "jsonSchema7" }
);
const getUserHistoryJsonSchema = zodToJsonSchema(getUserHistorySchema, {
  target: "jsonSchema7",
});
const recordInteractionJsonSchema = zodToJsonSchema(
  recordInteractionSchema,
  { target: "jsonSchema7" }
);
const getRecommendationsJsonSchema = zodToJsonSchema(
  getRecommendationsSchema,
  { target: "jsonSchema7" }
);

/* -------------------- MCP Server -------------------- */

const server = new Server(
  {
    name: process.env.MCP_SERVER_NAME || "recommendation-server",
    version: process.env.MCP_SERVER_VERSION || "1.0.0",
  },
  {
    capabilities: { tools: {} },
  }
);

/* -------------------- Tool List -------------------- */

server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: [
    {
      name: "search_products",
      description: "Search for products",
      inputSchema: searchProductsJsonSchema,
    },
    {
      name: "get_product_details",
      description: "Get product details",
      inputSchema: getProductDetailsJsonSchema,
    },
    {
      name: "get_user_history",
      description: "Get user interaction history",
      inputSchema: getUserHistoryJsonSchema,
    },
    {
      name: "get_recommendations",
      description: "Get personalized recommendations",
      inputSchema: getRecommendationsJsonSchema,
    },
    {
      name: "record_interaction",
      description: "Record user interaction",
      inputSchema: recordInteractionJsonSchema,
    },
  ],
}));

/* -------------------- Tool Execution -------------------- */

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;

  try {
    switch (name) {
      case "search_products":
        return { result: await searchProducts(args) };

      case "get_product_details":
        return { result: await getProductDetails(args) };

      case "get_user_history":
        return { result: await getUserHistory(args) };

      case "get_recommendations":
        return { result: await getRecommendations(args) };

      case "record_interaction":
        return { result: await recordInteraction(args) };

      default:
        throw new Error(`Unknown tool: ${name}`);
    }
  } catch (err: any) {
    console.error("Tool error:", name, err);
    throw new Error(err.message || "Tool execution failed");
  }
});

/* -------------------- Server Startup -------------------- */

async function main() {
  // ✅ DB connection check FIRST
  try {
    await pool.query("SELECT 1");
    console.error("✅ DB connection successful");
  } catch (e) {
    console.error("❌ DB connection failed");
    console.error(e);
    process.exit(1);
  }

  // ✅ Start MCP server
  const transport = new StdioServerTransport();
  await server.connect(transport);
  console.error("🚀 MCP Recommendation Server ready");
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
