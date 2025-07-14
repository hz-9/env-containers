#!/bin/bash

# GeoServer Single-Container Startup Script
# Start GeoServer single instance container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting GeoServer Single-Container service..."
echo "Project root: ${root}"

# Start services
docker compose -p geoserver-single -f "${root}/compose/docker-compose.yml" up -d

echo "GeoServer Single-Container service started successfully!"
echo ""
echo "Access URL:"
echo "  Web Interface: http://127.0.0.1:8080/geoserver"
echo ""
echo "Default credentials:"
echo "  Username: admin"
echo "  Password: geoserver"
echo ""
echo "Check status: docker compose -p geoserver-single ps"
