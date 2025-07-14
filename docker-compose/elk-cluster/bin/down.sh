#!/bin/bash

# ELK Cluster Shutdown Script
# Stop ELK cluster (Elasticsearch, Kibana, Logstash, Filebeat, Metricbeat)

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping ELK Cluster services..."

# Stop services
docker compose -p elk-cluster --env-file "${root}/.env" -f "${root}/compose/docker-compose.yml" down

echo "ELK Cluster services stopped successfully!"
echo ""
echo "Data volume retention notice:"
echo "- Elasticsearch data: ${root}/temp/elasticsearch/"
echo "- Kibana data: ${root}/temp/kibana/"
echo "- Other services data: ${root}/temp/"
echo ""
echo "To completely clean up data, manually delete the temp directory"
