#!/bin/bash

# Elasticsearch Cluster Shutdown Script
# Stop Elasticsearch cluster (3 nodes) + Kibana

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping Elasticsearch Cluster..."

# Stop services
docker compose -p elasticsearch-cluster --env-file "${root}/.env" -f "${root}/compose/docker-compose.yml" down

echo "Elasticsearch Cluster stopped successfully!"
echo ""
echo "Data volume retention notice:"
echo "- Elasticsearch certificates: ${root}/temp/certs/"
echo "- Elasticsearch Node 1 data: ${root}/temp/esdata01/"
echo "- Elasticsearch Node 1 logs: ${root}/temp/eslogs01/"
echo "- Elasticsearch Node 1 plugins: ${root}/temp/esplugins01/"
echo "- Elasticsearch Node 2 data: ${root}/temp/esdata02/"
echo "- Elasticsearch Node 2 logs: ${root}/temp/eslogs02/"
echo "- Elasticsearch Node 2 plugins: ${root}/temp/esplugins02/"
echo "- Elasticsearch Node 3 data: ${root}/temp/esdata03/"
echo "- Elasticsearch Node 3 logs: ${root}/temp/eslogs03/"
echo "- Elasticsearch Node 3 plugins: ${root}/temp/esplugins03/"
echo "- Kibana data: ${root}/temp/kibanadata/"
echo ""
echo "To completely clean data, please manually delete the temp directory"
