#!/bin/bash

# Kafka Multi-Container Startup Script (KRaft Mode)
# Start Kafka cluster containers (without ZooKeeper)

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting Kafka Multi-Container services (KRaft Mode)..."
echo "Project root: ${root}"

# Start services
docker compose -p kafka-cluster -f "${root}/compose/docker-compose.yml" up -d

echo "Kafka Multi-Container services started successfully!"
echo ""
echo "Access URLs:"
echo "  Kafka Cluster: localhost:9092,localhost:9094,localhost:9096"
echo "  Kafka UI Web: http://localhost:9080"
echo ""
echo "Individual Broker Access:"
echo "  Kafka-1: localhost:9092 (Controller+Broker)"
echo "  Kafka-2: localhost:9094 (Controller+Broker)"
echo "  Kafka-3: localhost:9096 (Controller+Broker)"
echo ""
echo "Test commands:"
echo "  # List topics"
echo "  docker exec kafka-1 kafka-topics.sh --list --bootstrap-server localhost:9092"
echo "  # Create topic"
echo "  docker exec kafka-1 kafka-topics.sh --create --topic test --bootstrap-server localhost:9092"
echo ""
echo "Check status: docker compose -p kafka-cluster ps"
