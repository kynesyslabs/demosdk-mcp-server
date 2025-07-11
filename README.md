# Demos SDK MCP Server

An MCP (Model Context Protocol) server that provides access to the Demos Network SDK documentation. This server scrapes and indexes the Demos Network GitBook documentation, making it searchable and accessible through MCP tools for AI assistants.

## Installation

Run the installation script:

```bash
chmod +x install.sh
./install.sh
```

This will:
- Copy the Demos SDK configuration file
- Install dependencies
- Build the project
- Install globally for easy access

## Configuration

### Quick Start

The Demos SDK MCP server comes pre-configured for the Demos Network documentation:

```bash
# Already configured for https://docs.kynesys.xyz
npm start
```

The server includes:
- Pre-configured access to Demos Network documentation
- Demos SDK specific tool prefixes (`demos_network_sdk_`)
- Keywords for multichain, XM, web2, DAHR, and cross-chain functionality

### Advanced Configuration

The server is pre-configured for Demos Network, but you can customize settings in `.env.demosdk`:

**Pre-configured settings:**
- `GITBOOK_URL=https://docs.kynesys.xyz` - Demos Network documentation
- `SERVER_NAME=demos-network-docs` - Server identifier
- `TOOL_PREFIX=demos_network_sdk_` - Tool naming prefix
- `DOMAIN_KEYWORDS` - Includes demos, sdk, multichain, xm, web2, dahr, crosschain

**Performance settings:**
- `CACHE_TTL_HOURS=1` - Cache expiration time
- `MAX_CONCURRENT_REQUESTS=5` - Parallel scraping limit
- `SCRAPING_DELAY_MS=100` - Delay between requests

**Customization:**
To modify the configuration, edit `.env.demosdk` or create a new `.env` file with your custom settings.

## Usage

### Running the Server

```bash
npm start
```

### Installing in Claude Desktop

After running the installation script, add to your `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "demos-sdk": {
      "command": "demosdk-mcp-server"
    }
  }
}
```

Config file locations:
- **macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`
- **Windows**: `%APPDATA%\Claude\claude_desktop_config.json`

### Adding to Claude Code

```bash
claude mcp add demosdk-mcp-server
```

### Testing with MCP Inspector

```bash
npx @modelcontextprotocol/inspector node dist/index.js
```

### Running as REST API

```bash
# Start REST API server on port 3000
npm run start:api

# Or specify custom port
PORT=8080 npm run start:api
```

The REST API provides HTTP endpoints for all MCP functionality:

```bash
# API documentation
curl http://localhost:3000/api

# Search content
curl "http://localhost:3000/api/search?q=authentication"

# Get specific page
curl http://localhost:3000/api/page/sdk/websdk

# Get page as markdown
curl http://localhost:3000/api/page/sdk/websdk/markdown

# Get code blocks from page
curl http://localhost:3000/api/page/api/endpoints/code

# List all sections
curl http://localhost:3000/api/sections

# Get pages in a section
curl http://localhost:3000/api/sections/SDK/pages

# Server status and stats
curl http://localhost:3000/api/status

# Refresh content cache
curl -X POST http://localhost:3000/api/refresh
```

### Available Tools

The Demos SDK MCP server exposes the following tools with the `demos_network_sdk_` prefix:

**Core Tools:**

1. **`demos_network_sdk_search_content`** - Search across Demos Network documentation
   - `query` (string): Search query with fuzzy matching and stemming

2. **`demos_network_sdk_get_page`** - Get a specific documentation page
   - `path` (string): Page path (e.g., "/sdk/getting-started")

3. **`demos_network_sdk_list_sections`** - Get the complete table of contents

4. **`demos_network_sdk_get_section_pages`** - Get all pages in a section
   - `section` (string): Section name (e.g., "SDK Reference")

5. **`demos_network_sdk_refresh_content`** - Force refresh of cached content

6. **`demos_network_sdk_get_code_blocks`** - Extract code blocks with syntax highlighting
   - `path` (string): Page path (e.g., "/sdk/examples")

7. **`demos_network_sdk_get_markdown`** - Get page content as formatted markdown
   - `path` (string): Page path (e.g., "/api/reference")

**MCP Prompts:**

1. **`explain_section`** - Generate comprehensive section tutorials
2. **`summarize_page`** - Create concise page summaries  
3. **`compare_sections`** - Compare different documentation sections
4. **`api_reference`** - Format content as API documentation
5. **`quick_start_guide`** - Generate quick start guides

### Example Usage

Using the Demos SDK MCP server tools:

```bash
# Search for SDK documentation
{"tool": "demos_network_sdk_search_content", "arguments": {"query": "multichain integration"}}

# Get a specific page
{"tool": "demos_network_sdk_get_page", "arguments": {"path": "/sdk/getting-started"}}

# List all sections
{"tool": "demos_network_sdk_list_sections", "arguments": {}}

# Get pages in SDK section
{"tool": "demos_network_sdk_get_section_pages", "arguments": {"section": "SDK Reference"}}

# Get code examples
{"tool": "demos_network_sdk_get_code_blocks", "arguments": {"path": "/sdk/examples"}}

# Refresh cached content
{"tool": "demos_network_sdk_refresh_content", "arguments": {}}
```

### AI Integration

The Demos SDK MCP server is optimized for AI assistant integration:

**When the AI will use this MCP:**
- Questions about Demos Network SDK usage
- Multichain development and cross-chain integration
- Web2 to Web3 bridging (DAHR) questions
- XM protocol implementation
- SDK examples and code snippets

**Domain-specific features:**
- Specialized in blockchain and multichain development
- Includes Demos Network specific terminology
- Optimized for SDK documentation and API references

## Architecture

- **`GitBookScraper`**: Handles web scraping, content extraction, and markdown conversion
- **`ContentStore`**: Manages content storage and advanced search functionality
- **`GitBookMCPServer`**: Main MCP server implementation with tool handlers
- **`GitBookRestAPI`**: Express.js REST API server with HTTP endpoints
- **`DomainDetector`**: Auto-detection of domain branding and keywords
- **`TextProcessor`**: Content processing with stemming and normalization

## Development

```bash
# Development mode with auto-reload
npm run dev

# Build
npm run build

# Run built version
npm start
```

## How It Works

1. **Domain Detection**: Analyzes your GitBook content to detect domain and keywords
2. **Parallel Scraping**: Efficiently scrapes all pages using configurable concurrency
3. **Smart Indexing**: Processes content with stemming, normalization, and fuzzy search
4. **Change Detection**: Only re-scrapes modified pages for optimal performance
5. **MCP Integration**: Exposes domain-specific tools and prompts for AI assistants

## Demos Network SDK Support

This MCP server is specifically configured for the Demos Network SDK documentation at `docs.kynesys.xyz`:

- **SDK Documentation** - Complete Demos Network SDK reference
- **API References** - REST and GraphQL endpoints
- **Developer Guides** - Integration tutorials and examples
- **Multichain Support** - Cross-chain development guides
- **XM Protocol** - Extended messaging protocol documentation
- **DAHR Integration** - Web2 to Web3 bridging guides

**Specialized for:**
- Blockchain and multichain development
- Cross-chain communication protocols
- Web2 to Web3 integration patterns
- Demos Network ecosystem tools

## Limitations

- **Public GitBooks only** - Requires publicly accessible GitBook sites
- **Static content** - Not API-based, scrapes published HTML
- **Manual refresh** - No real-time updates (use `refresh_content` tool)
- **Text-focused** - Extracts text content, not complex interactive elements

## Deployment Options

**Local Development:**
```bash
npm run dev  # Development mode with auto-reload
```

**Production MCP Server:**
```bash
npm run build && npm start
```

**Production REST API:**
```bash
npm run build && npm run start:api
```

**Docker (optional):**
```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY dist/ ./dist/
CMD ["npm", "start"]
```

**Claude Desktop Integration:**
```json
{
  "mcpServers": {
    "demos-sdk": {
      "command": "demosdk-mcp-server"
    }
  }
}
```

## License

MIT