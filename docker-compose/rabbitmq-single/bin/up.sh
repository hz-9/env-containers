#!/bin/bash

# RabbitMQ Single-Container Startup Script
# Start RabbitMQ single instance

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting RabbitMQ Single-Container service..."
echo "Project root: ${root}"

# Create necessary directories
echo "Setting up data directories..."
mkdir -p "${root}/temp/data"
mkdir -p "${root}/temp/logs"
mkdir -p "${root}/temp/config"

# Create plugin configuration file
echo "Creating RabbitMQ configuration..."
cat > "${root}/temp/config/enabled_plugins" << 'EOF'
[rabbitmq_management,rabbitmq_prometheus].
EOF

# Set correct permissions
chmod 644 "${root}/temp/config/enabled_plugins"

# Start services
docker compose -p rabbitmq-single -f "${root}/compose/docker-compose.yml" up -d

echo "RabbitMQ Single-Container service started successfully!"
echo ""
echo "Service Access Info:"
echo "  AMQP Protocol: amqp://localhost:5672"
echo "  Management UI: http://localhost:15672"
echo "  Prometheus Metrics: http://localhost:15692/metrics"
echo ""
echo "Credentials:"
echo "  Username: hz_9"
echo "  Password: 123456"
echo "  Virtual Host: /"
echo ""
echo "Connection Examples:"
echo "  # Python (pika)"
echo "  import pika"
echo "  connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))"
echo ""
echo "  # Node.js (amqplib)"
echo "  const amqp = require('amqplib');"
echo "  const connection = await amqp.connect('amqp://hz_9:123456@localhost:5672/');"
echo ""
echo "Data directory: ${root}/temp/"
echo "Check status: docker compose -p rabbitmq-single ps"
