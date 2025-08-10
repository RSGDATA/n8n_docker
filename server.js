// server.js - serves Google verify file, proxies everything else to n8n
const path = require("path");
const express = require("express");
const { createProxyMiddleware } = require("http-proxy-middleware");

const app = express();

// your verification filename EXACTLY as downloaded
const verifyFilename = "google5cdea5b341b11800.html";
const verifyFilePath = path.join(__dirname, verifyFilename);

// serve the verify file at the root path
app.get(`/${verifyFilename}`, (req, res) => {
  res.sendFile(verifyFilePath, (err) => {
    if (err) {
      console.error("Failed to send verify file:", err);
      res.status(500).send("Internal Server Error");
    }
  });
});

// proxy everything else to n8n running on 5679
app.use(
  "/",
  createProxyMiddleware({
    target: "http://127.0.0.1:5679",
    changeOrigin: true,
    ws: true,
    onError(err, req, res) {
      console.error("Proxy error:", err);
      res.writeHead(502);
      res.end("Bad gateway");
    },
  })
);

// Render provides PORT; fall back to 5678 locally
const PORT = process.env.PORT || 5678;
app.listen(PORT, () => {
  console.log(`Proxy listening on ${PORT}, verifying file at /${verifyFilename}`);
});
