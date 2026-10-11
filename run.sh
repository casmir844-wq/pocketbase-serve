#!/bin/sh
set -eu

# Validate required B2 environment variables
for var in B2_BUCKET_NAME B2_ENDPOINT B2_REGION B2_ACCESS_KEY_ID B2_SECRET_ACCESS_KEY; do
  eval "value=\$$var"
  if [ -z "$value" ]; then
    echo "Missing required env var: $var"
    exit 1
  fi
done

echo "Checking Backblaze B2 for an existing database backup..."
litestream -config /etc/litestream.yml restore -if-db-not-exists -if-replica-exists /pb/pb_data/data.db

echo "Starting PocketBase with Litestream replication active..."
exec litestream -config /etc/litestream.yml replicate -exec "pocketbase serve --http=0.0.0.0:8080 --dir /pb/pb_data"
