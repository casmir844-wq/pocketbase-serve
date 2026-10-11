#!/bin/sh
set -e

# 1. Check Backblaze B2 for an existing database snapshot to download
echo "Checking Backblaze B2 for an existing database backup..."
litestream restore -if-db-not-exists -if-replica-exists /pb/pb_data/data.db

# 2. Hand off control to Litestream to replicate database transactions while PocketBase serves requests
echo "Starting PocketBase with Litestream replication active..."
exec litestream replicate -exec "pocketbase serve --http=0.0.0.0:8080"
