FROM n8nio/n8n:latest

# Work inside /app
WORKDIR /app

# Copy the Google verify file and the node server
COPY google5cdea5b341b11800.html /app/google5cdea5b341b11800.html
COPY server.js /app/server.js

# Install the tiny proxy deps
RUN npm init -y && npm install express http-proxy-middleware

# Make sure n8n listens on its internal port (matches what you’ve set in Render)
ENV N8N_PORT=5678

# Drop to the non-root user used by the base image
USER node

# Start the node proxy (which spawns n8n internally)
CMD ["node", "/app/server.js"]
