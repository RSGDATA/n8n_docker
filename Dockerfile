FROM n8nio/n8n:latest

USER root
WORKDIR /app

# Copy the Google verify file and the proxy server
COPY google5cdea5b341b11800.html /app/google5cdea5b341b11800.html
COPY server.js /app/server.js

# Install minimal deps for the proxy
RUN npm init -y && npm install express http-proxy-middleware

# Run n8n on an internal port; proxy will listen on $PORT
ENV N8N_PORT=5679

# Drop back to non-root (n8n runs as node)
USER node

# Start n8n in the background, then start the proxy
CMD ["bash","-lc","n8n start & node /app/server.js"]
