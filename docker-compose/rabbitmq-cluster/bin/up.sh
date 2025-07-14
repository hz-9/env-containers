#!/bin/bash

# RabbitMQ Cluster Startup Script
# Start RabbitMQ cluster

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting RabbitMQ Cluster..."
echo "Project root: ${root}"

# Create necessary directories
echo "Setting up data directories..."
mkdir -p "${root}/temp/rabbitmq-1/data"
mkdir -p "${root}/temp/rabbitmq-1/logs"
mkdir -p "${root}/temp/rabbitmq-1/config"
mkdir -p "${root}/temp/rabbitmq-2/data"
mkdir -p "${root}/temp/rabbitmq-2/logs"
mkdir -p "${root}/temp/rabbitmq-2/config"
mkdir -p "${root}/temp/rabbitmq-3/data"
mkdir -p "${root}/temp/rabbitmq-3/logs"
mkdir -p "${root}/temp/rabbitmq-3/config"

# Create plugin configuration file
echo "Creating RabbitMQ configuration..."
cat > "${root}/temp/rabbitmq-1/config/enabled_plugins" << 'EOF'
[rabbitmq_management,rabbitmq_prometheus,rabbitmq_peer_discovery_common,rabbitmq_peer_discovery_classic_config].
EOF

cat > "${root}/temp/rabbitmq-2/config/enabled_plugins" << 'EOF'
[rabbitmq_management,rabbitmq_prometheus,rabbitmq_peer_discovery_common,rabbitmq_peer_discovery_classic_config].
EOF

cat > "${root}/temp/rabbitmq-3/config/enabled_plugins" << 'EOF'
[rabbitmq_management,rabbitmq_prometheus,rabbitmq_peer_discovery_common,rabbitmq_peer_discovery_classic_config].
EOF

# Set correct permissions
chmod 644 "${root}/temp/rabbitmq-1/config/enabled_plugins"
chmod 644 "${root}/temp/rabbitmq-2/config/enabled_plugins"
chmod 644 "${root}/temp/rabbitmq-3/config/enabled_plugins"

# Start services
docker compose -p rabbitmq-cluster -f "${root}/compose/docker-compose.yml" up -d

echo "Waiting for cluster formation..."
sleep 30

echo "RabbitMQ Cluster started successfully!"
echo ""
echo "Service Access Info:"
echo "  Load Balanced AMQP: amqp://localhost:5675"
echo "  Load Balanced Management: http://localhost:15675"
echo "  HAProxy Stats: http://localhost:8404 (admin/123456)"
echo ""
echo "Individual Node Access:"
echo "  RabbitMQ-1 AMQP: amqp://localhost:5672"
echo "  RabbitMQ-1 Management: http://localhost:15672"
echo "  RabbitMQ-2 AMQP: amqp://localhost:5673"
echo "  RabbitMQ-2 Management: http://localhost:15673"
echo "  RabbitMQ-3 AMQP: amqp://localhost:5674"
echo "  RabbitMQ-3 Management: http://localhost:15674"
echo ""
echo "Credentials:"
echo "  Username: hz_9"
echo "  Password: 123456"
echo "  Virtual Host: /"
echo ""
echo "Cluster Status Check:"
echo "  docker exec rabbitmq-1 rabbitmqctl cluster_status"
echo ""
echo "Data directories: ${root}/temp/rabbitmq-*/"
echo "Check status: docker compose -p rabbitmq-cluster ps"
