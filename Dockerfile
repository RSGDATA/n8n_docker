FROM n8nio/n8n:latest

# we need perms to write into image paths
USER root

# put the file in every likely static dir
# (some builds use /public, some /dist/public, some copy to a cache dir at runtime)
COPY google5cdea5b341b11800.html /usr/local/lib/node_modules/n8n/public/google5cdea5b341b11800.html
COPY google5cdea5b341b11800.html /usr/local/lib/node_modules/n8n/dist/public/google5cdea5b341b11800.html
COPY google5cdea5b341b11800.html /home/node/.cache/n8n/public/google5cdea5b341b11800.html

# make sure the running user owns these
RUN mkdir -p /home/node/.cache/n8n/public && \
    chown -R node:node /home/node/.cache/n8n && \
    chown -R node:node /usr/local/lib/node_modules/n8n

# drop back to the non-root user n8n runs as
USER node
