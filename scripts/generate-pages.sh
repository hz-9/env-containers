#!/bin/bash

# Generate documentation pages with @hz-9/docs-build

set -e

echo ""
echo "=== Generating documentation pages with @hz-9/docs-build ==="
npx @hz-9/docs-build -c docs-build.config.json
