#!/bin/sh
set -e

PKG_PUBLIC="/usr/local/lib/node_modules/n8n/dist/public"
CACHE_PUBLIC="/home/node/.cache/n8n/public"

# ensure dirs exist and copy to both spots
mkdir -p "$PKG_PUBLIC" "$CACHE_PUBLIC"
cp -f /opt/gsverify.html "$PKG_PUBLIC/google5cdea5b341b11800.html" || true
cp -f /opt/gsverify.html "$CACHE_PUBLIC/google5cdea5b341b11800.html" || true

# start the original n8n entrypoint
exec /docker-entrypoint.sh n8n
