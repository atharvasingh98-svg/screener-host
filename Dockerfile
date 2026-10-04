# Hosts screener-mcp as a remote MCP server over streamable HTTP.
# Render / Railway / Koyeb inject $PORT; screener-mcp reads PORT first.
FROM python:3.13-slim

RUN pip install --no-cache-dir screener-mcp

# streamable-http turns the stdio MCP server into a network server.
ENV MCP_TRANSPORT=streamable-http
ENV MCP_HOST=0.0.0.0

# SCREENER_USERNAME and SCREENER_PASSWORD are NOT set here on purpose.
# Set them as environment variables in your host's dashboard so they
# never land in git.

CMD ["screener-mcp"]
