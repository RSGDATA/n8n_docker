FROM n8nio/n8n:latest

# Work inside /app
WORKDIR /app

# Copy the Google verify file and the node server
COPY google5cdea5b341b11800.html /app/google5cdea5b341b11800.html
COPY server.js /app/server.js

# Install the tiny proxy deps
RUN npm init -y && npm install express http-proxy-middleware

# Make sure n8n listens on its internal port (matches what you've set in Render)
ENV N8N_PORT=5678

# Debug: Let's see what's available and try different approaches
CMD ["sh", "-c", "echo 'PATH:' $PATH && echo 'which node:' $(which node 2>/dev/null || echo 'not found') && echo 'ls /usr/local/bin:' && ls -la /usr/local/bin/ | grep node && echo 'Starting server...' && exec $(which node || echo '/usr/local/bin/node') /app/server.js"]
