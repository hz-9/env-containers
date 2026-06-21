# Docker Compose 容器编排规范

各环境的镜像版本、端口映射及通用约定的详细说明。

## 环境目录

### 数据库系统

| 环境           | 镜像                         | 端口                | Web 界面 | 类型           |
| -------------- | ---------------------------- | ------------------- | -------- | -------------- |
| postgis-single | `mdillon/postgis:9.6-alpine` | 5432                | —        | 单节点         |
| postgis-multi  | `mdillon/postgis:9.6-alpine` | 5432, 5433, 5434    | —        | 集群（3 节点） |
| mongodb-single | `mongo:4.0-xenial`           | 27017               | —        | 单节点         |
| mongodb-multi  | `mongo:4.0-xenial`           | 27017, 27018, 27019 | —        | 集群（3 节点） |

### 消息队列

| 环境             | 镜像                        | 端口                                | Web 界面                                | 类型                     |
| ---------------- | --------------------------- | ----------------------------------- | --------------------------------------- | ------------------------ |
| kafka-single     | `apache/kafka:3.9.1`        | 9092, 9093                          | Kafka UI @ `:9080`                      | 单节点（KRaft）          |
| kafka-cluster    | `apache/kafka:3.9.1`        | 9092–9097                           | Kafka UI @ `:9080`                      | 集群（3 节点，KRaft）    |
| rabbitmq-single  | `rabbitmq:4.1.2-management` | 5672, 15672, 15692                  | 管理界面 @ `:15672`                     | 单节点                   |
| rabbitmq-cluster | `rabbitmq:4.1.2-management` | 5672–5675, 15672–15675, 25672–25674 | 各节点管理界面 + HAProxy 统计 @ `:8404` | 集群（3 节点 + HAProxy） |

### 搜索引擎与可观测性

| 环境                  | 镜像                                                                                                   | 端口             | Web 界面         | 类型                    |
| --------------------- | ------------------------------------------------------------------------------------------------------ | ---------------- | ---------------- | ----------------------- |
| elasticsearch-single  | `elasticsearch:8.13.4` + `kibana:8.13.4`                                                               | 9200             | Kibana @ `:5601` | 单节点 + Kibana         |
| elasticsearch-cluster | `elasticsearch:8.13.4` + `kibana:8.13.4`                                                               | 9200             | Kibana @ `:5601` | 集群（3 节点）+ Kibana  |
| elk-cluster           | `elasticsearch:8.13.4` + `kibana:8.13.4` + `logstash:8.13.4` + `filebeat:8.13.4` + `metricbeat:8.13.4` | 9200, 5601, 5044 | Kibana @ `:5601` | 完整 ELK 全家桶 + Beats |

> **凭证**：`elastic` / `123456`（所有 Elastic 生态环境通用）。启用 HTTPS 及自动证书。

### 对象存储

| 环境         | 镜像                                       | 端口                        | Web 界面         | 类型   |
| ------------ | ------------------------------------------ | --------------------------- | ---------------- | ------ |
| minio-single | `minio/minio:RELEASE.2025-05-24T17-08-30Z` | 9000（API）, 9001（控制台） | 控制台 @ `:9001` | 单节点 |

> **凭证**：`hz_9` / `12345678`

### CI/CD 与仓库管理

| 环境             | 镜像                         | 端口        | Web 界面 | 类型                                    |
| ---------------- | ---------------------------- | ----------- | -------- | --------------------------------------- |
| jenkins-single   | `jenkinsci/blueocean:1.25.7` | 8080, 50000 | `:8080`  | 单节点（root 用户，挂载 Docker socket） |
| nexus-single     | `sonatype/nexus3:3.66.0`     | 8081        | `:8081`  | 单节点（root 用户）                     |
| verdaccio-single | `verdaccio/verdaccio:6.1.5`  | 4873        | `:4873`  | 单节点                                  |

> Nexus 初始密码可通过 `docker exec nexus cat /nexus-data/admin.password` 查看。

### 地理空间

| 环境             | 镜像                          | 端口 | Web 界面          | 类型   |
| ---------------- | ----------------------------- | ---- | ----------------- | ------ |
| geoserver-single | `oscarfonts/geoserver:2.27.1` | 8080 | `:8080/geoserver` | 单节点 |

> **凭证**：`admin` / `geoserver`

### 服务发现

| 环境              | 镜像            | 端口             | Web 界面               | 类型                         |
| ----------------- | --------------- | ---------------- | ---------------------- | ---------------------------- |
| zookeeper-single  | `zookeeper:3.5` | 2181             | ZooNavigator @ `:9000` | 单节点 + ZooNavigator        |
| zookeeper-cluster | `zookeeper:3.5` | 2181, 2182, 2183 | ZooNavigator @ `:9000` | 集群（3 节点）+ ZooNavigator |

> ZooNavigator 连接串（集群模式）：`zoo1:2181,zoo2:2181,zoo3:2181`

### AI / 机器学习

| 环境                   | 镜像                                         | 端口 | Web 界面 | 类型                                             |
| ---------------------- | -------------------------------------------- | ---- | -------- | ------------------------------------------------ |
| stable-diffusion-webui | `universonic/stable-diffusion-webui:minimal` | 8080 | `:8080`  | 单节点（需要 NVIDIA GPU，使用 `nvidia` runtime） |

## 数据卷约定

所有环境将持久化数据存放在各自目录下的 `temp/` 文件夹中。唯一例外是需要从项目目录直接挂载的配置文件。

```
docker-compose/<环境名称>/
├── temp/          ← 持久化数据（运行时创建）
│   ├── data/      ← 数据库 / 服务数据文件
│   ├── logs/      ← 服务日志文件
│   └── plugins/   ← 扩展 / 插件文件（如 GeoServer 扩展）
├── compose/
│   └── docker-compose.yml
└── bin/
    ├── up.sh
    └── down.sh
```

## 默认凭证

如无特别说明，适用以下凭证：

| 服务              | 用户名    | 密码        |
| ----------------- | --------- | ----------- |
| 通用约定          | `hz_9`    | `123456`    |
| Elastic（Kibana） | `elastic` | `123456`    |
| MinIO 控制台      | `hz_9`    | `12345678`  |
| RabbitMQ 管理界面 | `hz_9`    | `123456`    |
| GeoServer         | `admin`   | `geoserver` |
| HAProxy 统计界面  | `admin`   | `123456`    |

## 环境变量配置

Elastic 生态相关环境（`elasticsearch-single`、`elasticsearch-cluster`、`elk-cluster`）共用 `.env` 配置模式：

| 变量                                             | 值               | 说明                   |
| ------------------------------------------------ | ---------------- | ---------------------- |
| `STACK_VERSION`                                  | `8.13.4`         | Elastic Stack 版本     |
| `ELASTIC_PASSWORD`                               | `123456`         | Elasticsearch 密码     |
| `KIBANA_PASSWORD`                                | `123456`         | Kibana 系统用户密码    |
| `CLUSTER_NAME`                                   | `docker-cluster` | 集群名称               |
| `LICENSE`                                        | `basic`          | 许可级别               |
| `ES_MEM_LIMIT` / `KB_MEM_LIMIT` / `LS_MEM_LIMIT` | `1073741824`     | 各服务内存限制（1 GB） |

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
- stable-diffusion-webui(universonic/stable-diffusion-webui:minimal) 单实例 + Web 界面

## 数据卷

除了需要在当前目录加载的配置内容外，所有数据卷都需要在相应文件夹下创建 `temp` 目录。

## 环境变量

默认数据库和用户名都可以使用 `hz_9`。
默认密码可以使用 `123456`。
