# Docker Compose GeoServer Single-Container

## Overview

GeoServer single-instance containerized deployment solution, providing a GeoServer geospatial service instance for publishing and managing geospatial data.

## Service List

| Service Name | Container Name | Port Mapping | Network Alias | Purpose |
|--------------|----------------|--------------|---------------|---------|
| geoserver | geoserver | 8080:8080 | all.geoserver | Geospatial information service |

## Access Information

### Web Interface

```bash
# GeoServer Web Interface
http://127.0.0.1:8080/geoserver
```

### Network Internal Connection (Inter-container Communication)

```bash
# Connect via network alias
http://all.geoserver:8080/geoserver
```

## Quick Start

### Start Services

```bash
# Start using script
./bin/up.sh

# Or use docker compose directly
docker compose -p geoserver-single -f compose/docker-compose.yml up -d
```

### Stop Services

```bash
# Stop using script
./bin/down.sh

# Or use docker compose directly
docker compose -p geoserver-single -f compose/docker-compose.yml down
```

### Check Status

```bash
docker compose -p geoserver-single -f compose/docker-compose.yml ps
```

## Data Persistence

Data is stored in host directories:

```text
geoserver/
└── ext/             # GeoServer extensions
temp/
└── geoserver/
    └── log/         # GeoServer logs
```

## Environment Configuration

### Application Configuration

- **Image Version**: oscarfonts/geoserver:2.27.1
- **Internal Port**: 8080
- **External Port**: 8080

### Network Configuration

- **Network Name**: all
- **Network Type**: bridge
- **Inter-container Communication**: Supported

## Default Credentials

### Administrator Account

- **Username**: admin
- **Password**: geoserver

## Service Configuration

### Supported Data Formats

- **Vector Data**: Shapefile, GeoJSON, KML
- **Raster Data**: GeoTIFF, JPEG, PNG
- **Databases**: PostGIS, Oracle Spatial, MySQL

### Common Service Types

- **WMS**: Web Map Service
- **WFS**: Web Feature Service  
- **WCS**: Web Coverage Service
- **WPS**: Web Processing Service

## Extension Modules

GeoServer supports various extension modules:

- **Vector Tiles**: Vector tiles support
- **Charting**: Charting support
- **Control Flow**: Control flow for request limiting
- **CSS Styling**: CSS styling support

## Use Cases

1. **Map Publishing**: Publish geospatial data as web services
2. **Spatial Data Management**: Manage various formats of spatial data
3. **Map Styling**: Create and manage map styles
4. **Spatial Analysis**: Provide basic spatial analysis functions

## Important Notes

1. Ensure port 8080 is not occupied
2. First startup may take several minutes
3. Ensure sufficient disk space for storing geographic data
4. Recommend changing default password for production environments
5. Recommend regular backup of GeoServer configuration and data
6. Additional extension modules can be installed as needed
