# Docker Compose Container Orchestration Example Specifications

## Container Examples

- postgis(mdillon/postgis:9.6-alpine) multi-instance
- postgis(mdillon/postgis:9.6-alpine) multi-instance
- mongo(mongo:4.0-xenial) multi-instance
- mongo(mongo:4.0-xenial) single instance
- jenkins(jenkinsci/blueocean:1.25.7) single instance
- nexus(sonatype/nexus3:3.66.0) single instance
- verdaccio(verdaccio/verdaccio:6.1.5) single instance
- geoserver(oscarfonts/geoserver:2.27.1) single instance
- zookeeper(zookeeper:3.5) cluster + visualization
- zookeeper(zookeeper:3.5) single instance + visualization
- kafka(apache/kafka:3.9.1) cluster + visualization
- kafka(apache/kafka:3.9.1) single instance + visualization
- elasticsearch(docker.elastic.co/elasticsearch/elasticsearch:8.13.4+docker.elastic.co/kibana/kibana:8.13.4) cluster + visualization
- elasticsearch(docker.elastic.co/elasticsearch/elasticsearch:8.13.4+docker.elastic.co/kibana/kibana:8.13.4) single instance + visualization
- rabbit(rabbitmq:4.1.2) cluster + visualization
- rabbit(rabbitmq:4.1.2) single instance + visualization
- ELK cluster + visualization
- Minio(minio/minio:RELEASE.2025-05-24T17-08-30Z) single instance

## Data Volumes

Except for configuration content that needs to be loaded in the current directory, all data volumes need to create a `temp` directory under the corresponding folder.

## Environment Variables

Default database and username can both use `hz_9`.
Default password can use `123456`.
