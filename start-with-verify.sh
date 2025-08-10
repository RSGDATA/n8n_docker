#!/bin/sh
set -e

SRC="/home/node/gsverify.html"
CACHE_DIR="/home/node/.cache/n8n/public"
DIST_DIR="/usr/local/lib/node_modules/n8n/dist/public"

# make sure the cache 'public' exists (writable by node)
mkdir -p "$CACHE_DIR"

# copy into both places n8n serves static assets from
cp -f "$SRC" "$CACHE_DIR/"

# this one may be read-only in some builds; ignore errors
cp -f "$SRC" "$DIST_DIR/" 2>/dev/null || true

# start n8n (the official image resolves this on PATH)
exec n8n
