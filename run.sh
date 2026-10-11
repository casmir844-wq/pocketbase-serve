#!/bin/sh
set -eu

echo "Starting PocketBase..."
exec pocketbase serve --http=0.0.0.0:8080 --dir /pb/pb_data
