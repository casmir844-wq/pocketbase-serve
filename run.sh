#!/bin/sh
set -eu

b2_ok=true
for var in B2_BUCKET_NAME B2_ENDPOINT B2_REGION B2_ACCESS_KEY_ID B2_SECRET_ACCESS_KEY; do
  eval "value=\${$var:-}"
  if [ -z "$value" ]; then
    b2_ok=false
    break
  fi
done

if [ "$b2_ok" = "true" ]; then
  echo "B2 configured. Starting PocketBase with Litestream replication..."
  exec litestream -config /etc/litestream.yml replicate -exec "pocketbase serve --http=0.0.0.0:8080 --dir /pb/pb_data"
fi

echo "B2 not configured. Starting PocketBase without replication..."
exec pocketbase serve --http=0.0.0.0:8080 --dir /pb/pb_data
