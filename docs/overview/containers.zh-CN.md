# Docker Compose 容器编排示例规范

## 容器示例

- postgis(mdillon/postgis:9.6-alpine) 多实例
- postgis(mdillon/postgis:9.6-alpine) 多实例
- mongo(mongo:4.0-xenial) 多实例
- mongo(mongo:4.0-xenial) 单实例
- jenkins(jenkinsci/blueocean:1.25.7) 单实例
- nexus(sonatype/nexus3:3.66.0) 单实例
- verdaccio(verdaccio/verdaccio:6.1.5) 单实例
- geoserver(oscarfonts/geoserver:2.27.1) 单实例
- zookeeper(zookeeper:3.5) 集群 + 可视化
- zookeeper(zookeeper:3.5) 单实例 + 可视化
- kafka(apache/kafka:3.9.1) 集群 + 可视化
- kafka(apache/kafka:3.9.1) 单实例 + 可视化
- elasticsearch(docker.elastic.co/elasticsearch/elasticsearch:8.13.4+docker.elastic.co/kibana/kibana:8.13.4) 集群 + 可视化
- elasticsearch(docker.elastic.co/elasticsearch/elasticsearch:8.13.4+docker.elastic.co/kibana/kibana:8.13.4) 单实例 + 可视化
- rabbit(rabbitmq:4.1.2) 集群 + 可视化
- rabbit(rabbitmq:4.1.2) 单实例 + 可视化
- ELK 集群 + 可视化
- Minio(minio/minio:RELEASE.2025-05-24T17-08-30Z) 单实例

## 数据卷

除了需要在当前目录加载的配置内容外，所有数据卷都需要在相应文件夹下创建 `temp` 目录。

## 环境变量

默认数据库和用户名都可以使用 `hz_9`。
默认密码可以使用 `123456`。
