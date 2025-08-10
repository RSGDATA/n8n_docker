FROM n8nio/n8n:latest

# keep the verify file in a safe place inside the image
COPY google5cdea5b341b11800.html /opt/gsverify.html

# wrapper that copies the file where n8n serves static assets, then starts n8n
COPY start-with-verify.sh /start-with-verify.sh
RUN chmod +x /start-with-verify.sh

ENTRYPOINT ["/start-with-verify.sh"]


