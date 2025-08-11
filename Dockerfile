FROM n8nio/n8n:latest

# Work inside /app
WORKDIR /app

# Copy the Google verify file and the node server
COPY --chown=node:node google5cdea5b341b11800.html /app/google5cdea5b341b11800.html
COPY --chown=node:node server.js /app/server.js

# Install the tiny proxy deps as root first
RUN npm init -y && npm install express http-proxy-middleware

# Find where node is installed and create a symlink
RUN which node && ln -sf $(which node) /usr/local/bin/node || true

# Make sure n8n listens on its internal port (matches what you've set in Render)
ENV N8N_PORT=5678

# Set PATH to include common node locations
ENV PATH="/usr/local/bin:/opt/nodejs/bin:$PATH"

# Drop to the non-root user used by the base image
USER node

# Use the full path or let PATH resolve it
CMD ["/usr/local/bin/node", "/app/server.js"]
