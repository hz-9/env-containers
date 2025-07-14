#!/bin/bash

# Kafka Single-Container Shutdown Script
# Stop Kafka single instance container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping Kafka Single-Container service..."

# Stop services
docker compose -p kafka-single -f "${root}/compose/docker-compose.yml" down

echo "Kafka Single-Container service stopped successfully!"
echo ""
echo "Data volume retention notice:"
echo "- Kafka data: ${root}/temp/kafka/data/"
echo "- Kafka logs: ${root}/temp/kafka/logs/"
echo ""
echo "To completely clean up data, manually delete the temp directory"
