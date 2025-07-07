#!/bin/bash
cp .env.demosdk .env
npm install
npm run build
chmod +x dist/index.js

# global install of mcp server
npm install -g .


echo "Demosdk compiled successfully."
echo "To run the Demos SDK MCP server, use the command:"
echo "npm run start"
echo "You can also add the mcp server to any tool by pointing them to demosdk-mcp-.server"
echo "For example, in claude code you can use:"
echo "claude mcp add demosdk-mcp-server"