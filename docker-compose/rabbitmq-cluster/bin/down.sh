#!/bin/bash

# RabbitMQ Cluster Shutdown Script
# Stop RabbitMQ cluster

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping RabbitMQ Cluster..."

# Stop services
docker compose -p rabbitmq-cluster -f "${root}/compose/docker-compose.yml" down

echo "RabbitMQ Cluster stopped successfully!"
echo ""
echo "Data volume retention notice:"
echo "- RabbitMQ-1 data: ${root}/temp/rabbitmq-1/"
echo "- RabbitMQ-2 data: ${root}/temp/rabbitmq-2/"
echo "- RabbitMQ-3 data: ${root}/temp/rabbitmq-3/"
echo ""
echo "To completely clean up data, manually delete the temp directory"
