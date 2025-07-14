#!/bin/bash

# Kafka Single-Container Startup Script (KRaft Mode)
# Start Kafka single instance container (without ZooKeeper)

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting Kafka Single-Container service (KRaft Mode)..."
echo "Project root: ${root}"

# Start services
docker compose -p kafka-single -f "${root}/compose/docker-compose.yml" up -d

echo "Kafka Single-Container service started successfully!"
echo ""
echo "Kafka Connection Info:"
echo "  Bootstrap Servers: localhost:9092"
echo "  Mode: KRaft (No ZooKeeper)"
echo ""
echo "Web UI:"
echo "  Kafka UI: http://localhost:9080"
echo ""
echo "Test commands:"
echo "  # Create topic"
echo "  docker exec kafka-single kafka-topics.sh --create --topic test --bootstrap-server localhost:9092"
echo "  # List topics"
echo "  docker exec kafka-single kafka-topics.sh --list --bootstrap-server localhost:9092"
echo ""
echo "Data directory: ${root}/temp/kafka/"
echo "Check status: docker compose -p kafka-single ps"
