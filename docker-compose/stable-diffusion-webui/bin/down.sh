#!/bin/bash

# Stable Diffusion WebUI Shutdown Script
# Stop Stable Diffusion WebUI container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping Stable Diffusion WebUI service..."

# Stop services
docker compose -p stable-diffusion-webui -f "${root}/compose/docker-compose.yml" down

echo "Stable Diffusion WebUI service stopped successfully!"
echo ""
echo "Data volume retention notice:"
echo "- Models: ${root}/temp/models/"
echo "- Outputs: ${root}/temp/outputs/"
echo "- Extensions: ${root}/temp/extensions/"
echo "- Embeddings: ${root}/temp/embeddings/"
echo "- Other data: ${root}/temp/"
echo ""
echo "To completely clean up data, manually delete the temp directory"
echo "Note: Model files can be large (GBs), consider backing up before deletion"