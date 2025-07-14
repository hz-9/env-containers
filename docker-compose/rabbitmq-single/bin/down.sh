#!/bin/bash

# RabbitMQ Single-Container Shutdown Script
# Stop RabbitMQ single instance

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping RabbitMQ Single-Container service..."

# Stop services
docker compose -p rabbitmq-single -f "${root}/compose/docker-compose.yml" down

echo "RabbitMQ Single-Container service stopped successfully!"
echo ""
echo "Data volume retention notice:"
echo "- RabbitMQ data: ${root}/temp/data/"
echo "- RabbitMQ logs: ${root}/temp/logs/"
echo ""
echo "To completely clean up data, manually delete the temp directory"
