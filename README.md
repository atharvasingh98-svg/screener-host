# screener-mcp host

Runs [screener-mcp](https://pypi.org/project/screener-mcp/) as a remote MCP
server so Claude can reach Screener.in data from the cloud.

The MCP endpoint is served at **`/mcp`** (the root path returns 404).

## Deploy

1. Create a **public** GitHub repo and upload `Dockerfile` and this README.
2. Go to **render.com** (or railway.app), sign in with GitHub.
3. **New → Web Service** → pick this repo.
4. Runtime: **Docker**. Instance type: the free tier is fine.
5. Add two environment variables:
   - `SCREENER_USERNAME` — your Screener.in email
   - `SCREENER_PASSWORD` — your Screener.in password
6. Deploy. You get a permanent URL like `https://your-app.onrender.com`.
7. In claude.ai → Settings → Connectors → **Add custom connector**, paste:
   `https://your-app.onrender.com/mcp`

## Checking it worked

The deploy log should show:

```
StreamableHTTP session manager started
Uvicorn running on http://0.0.0.0:10000
```

If it logs `No Screener credentials set — running in public mode (limited data)`,
the two environment variables did not take. Fundamental screening needs the login.

## Notes

- Use a Screener.in password you do not reuse anywhere else.
- Anyone with the URL can call this endpoint. Keep it private; it can read
  your Screener.in account.
- Render's free tier sleeps after ~15 minutes idle and takes ~50s to wake,
  so the first call after a gap may time out. Retry once.
