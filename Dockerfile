FROM n8nio/n8n:latest
USER root

# Put the Google verify file where this image serves static assets
COPY google5cdea5b341b11800.html /home/node/.cache/n8n/public/google5cdea5b341b11800.html

# Make sure the node user owns it
RUN mkdir -p /home/node/.cache/n8n/public && \
    chown -R node:node /home/node/.cache/n8n

USER node
