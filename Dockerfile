FROM n8nio/n8n:latest

# Work inside /app
WORKDIR /app

# Copy the Google verify file and the node server
COPY google5cdea5b341b11800.html /app/google5cdea5b341b11800.html
COPY server.js /app/server.js

# Install the tiny proxy deps as root first
RUN npm init -y && npm install express http-proxy-middleware

# Make sure n8n listens on its internal port (matches what you've set in Render)
ENV N8N_PORT=5678

# Ensure the node user has access to the files
RUN chown -R node:node /app

# Drop to the non-root user used by the base image
USER node

# Use a more robust approach to find and run node
CMD ["sh", "-c", "exec $(which node) /app/server.js"]
