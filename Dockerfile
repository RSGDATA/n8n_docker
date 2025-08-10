FROM n8nio/n8n:latest

# Put the verify file somewhere writable by 'node'
COPY google5cdea5b341b11800.html /home/node/gsverify.html

# Copy the wrapper script and mark it executable at copy-time (no RUN chmod needed)
COPY --chmod=0755 start-with-verify.sh /home/node/start-with-verify.sh

# Run our wrapper instead of the default entrypoint
ENTRYPOINT ["/home/node/start-with-verify.sh"]



