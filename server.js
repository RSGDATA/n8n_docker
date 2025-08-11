// /app/server.js
const { spawn } = require('child_process');
const path = require('path');
const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();

// n8n listens internally; keep it at 5678 (matches your env)
const N8N_INTERNAL_PORT = process.env.N8N_PORT || 5678;

// start n8n as a child process (use shell to find n8n in PATH)
const n8n = spawn('n8n', ['start'], {
  stdio: 'inherit',           // pipe logs to container logs
  env: process.env,           // pass through environment
  shell: true,                // use shell to resolve PATH
});

n8n.on('exit', (code) => {
  console.error(`n8n exited with code ${code}`);
  process.exit(code || 1);
});

// --- Google verification file ---
const verifyFilename = 'google5cdea5b341b11800.html';
const verifyFilePath = path.join('/app', verifyFilename);

// Serve verification file at the root path
app.get(`/${verifyFilename}`, (req, res) => {
  res.sendFile(verifyFilePath, (err) => {
    if (err) {
      console.error('Failed to send verify file:', err);
      res.status(500).send('Internal Server Error');
    }
  });
});

// --- Proxy everything else to n8n on 5678 ---
app.use(
  '/',
  createProxyMiddleware({
    target: `http://127.0.0.1:${N8N_INTERNAL_PORT}`,
    changeOrigin: true,
    ws: true,
    proxyTimeout: 120000,
    timeout: 120000,
    onError(err, req, res) {
      console.error('Proxy error:', err);
      if (!res.headersSent) {
        res.writeHead(502);
      }
      res.end('Bad gateway');
    },
  })
);

// Render provides PORT for the public listener
const PORT = process.env.PORT || 10000;
app.listen(PORT, () => {
  console.log(`Proxy listening on ${PORT}; verify at /${verifyFilename}`);
});
