#!/bin/bash

# Kafka Multi-Container Shutdown Script
# Stop Kafka cluster containers

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping Kafka Multi-Container services..."
echo "Project root: ${root}"

# Stop and remove services
docker compose -p kafka-cluster -f "${root}/compose/docker-compose.yml" down --rmi local

echo "Kafka Multi-Container services stopped successfully!"
echo ""
echo "Data volume retention notice:"
echo "- Kafka-1 data: ${root}/temp/kafka-1/"
echo "- Kafka-2 data: ${root}/temp/kafka-2/"
echo "- Kafka-3 data: ${root}/temp/kafka-3/"
echo ""
echo "To completely clean up data, manually delete the temp directory"
