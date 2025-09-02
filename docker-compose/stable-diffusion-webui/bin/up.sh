#!/bin/bash

# Stable Diffusion WebUI Startup Script
# Start Stable Diffusion WebUI container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting Stable Diffusion WebUI service..."
echo "Project root: ${root}"

# Create temp directories if they don't exist
mkdir -p "${root}/temp/inputs"
mkdir -p "${root}/temp/textual_inversion_templates"
mkdir -p "${root}/temp/embeddings"
mkdir -p "${root}/temp/extensions"
mkdir -p "${root}/temp/models"
mkdir -p "${root}/temp/localizations"
mkdir -p "${root}/temp/outputs"

# Check if NVIDIA Docker runtime is available
if ! docker info | grep -q "nvidia"; then
    echo "Warning: NVIDIA Docker runtime not detected. GPU acceleration may not work."
    echo "Please ensure nvidia-docker2 is installed and Docker daemon is configured properly."
fi

# Start services
docker compose -p stable-diffusion-webui -f "${root}/compose/docker-compose.yml" up -d

echo "Stable Diffusion WebUI service started successfully!"
echo ""
echo "Connection Info:"
echo "  Web Interface: http://localhost:8080"
echo ""
echo "Volume Mappings:"
echo "  Inputs: ${root}/temp/inputs/"
echo "  Models: ${root}/temp/models/"
echo "  Outputs: ${root}/temp/outputs/"
echo "  Extensions: ${root}/temp/extensions/"
echo "  Embeddings: ${root}/temp/embeddings/"
echo ""
echo "GPU Requirements:"
echo "  - NVIDIA GPU with CUDA support"
echo "  - NVIDIA Docker runtime"
echo "  - Sufficient VRAM (8GB+ recommended)"
echo ""
echo "Check status: docker compose -p stable-diffusion-webui ps"
echo "View logs: docker compose -p stable-diffusion-webui logs -f"