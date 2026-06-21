# 容器环境集合

一套生产就绪的 Docker Compose 配置集，用于快速搭建开发环境。每个环境遵循标准化的目录结构和统一的启停脚本。

## 快速开始

```bash
# 启动任意环境（例如 MongoDB 单节点）
cd docker-compose/mongodb-single
./bin/up.sh

# 完成后停止
./bin/down.sh
```

## 可用环境一览

### 数据库系统

| 环境                                     | 类型                      | 镜像                         | 端口        | Web 界面 |
| ---------------------------------------- | ------------------------- | ---------------------------- | ----------- | -------- |
| [PostGIS](docker-compose/postgis-single) | 单节点 / 集群（3 节点）   | `mdillon/postgis:9.6-alpine` | 5432–5434   | —        |
| [MongoDB](docker-compose/mongodb-single) | 单节点 / 多节点（3 节点） | `mongo:4.0-xenial`           | 27017–27019 | —        |

### 消息队列

| 环境                                       | 类型                                | 镜像                        | 端口                   | Web 界面                |
| ------------------------------------------ | ----------------------------------- | --------------------------- | ---------------------- | ----------------------- |
| [Kafka](docker-compose/kafka-single)       | 单节点 / 集群（3 节点，KRaft 模式） | `apache/kafka:3.9.1`        | 9092–9097              | Kafka UI @ `:9080`      |
| [RabbitMQ](docker-compose/rabbitmq-single) | 单节点 / 集群（3 节点 + HAProxy）   | `rabbitmq:4.1.2-management` | 5672–5675, 15672–15675 | 管理界面 + HAProxy 统计 |

### 搜索引擎与可观测性

| 环境                                                 | 类型                                                   | 镜像                                                         | 端口             | Web 界面         |
| ---------------------------------------------------- | ------------------------------------------------------ | ------------------------------------------------------------ | ---------------- | ---------------- |
| [Elasticsearch](docker-compose/elasticsearch-single) | 单节点 / 集群（3 节点）                                | `elasticsearch:8.13.4`                                       | 9200             | Kibana @ `:5601` |
| [ELK 全家桶](docker-compose/elk-cluster)             | 集群（ES + Logstash + Kibana + Filebeat + Metricbeat） | `elasticsearch:8.13.4` / `logstash:8.13.4` / `kibana:8.13.4` | 9200, 5601, 5044 | Kibana @ `:5601` |

### 对象存储

| 环境                                 | 类型   | 镜像                             | 端口                      | Web 界面         |
| ------------------------------------ | ------ | -------------------------------- | ------------------------- | ---------------- |
| [MinIO](docker-compose/minio-single) | 单节点 | `minio/minio:RELEASE.2025-05-24` | 9000 (API), 9001 (控制台) | 控制台 @ `:9001` |

### CI/CD 与仓库管理

| 环境                                         | 类型                   | 镜像                         | 端口        | Web 界面 |
| -------------------------------------------- | ---------------------- | ---------------------------- | ----------- | -------- |
| [Jenkins](docker-compose/jenkins-single)     | 单节点（BlueOcean）    | `jenkinsci/blueocean:1.25.7` | 8080, 50000 | `:8080`  |
| [Nexus](docker-compose/nexus-single)         | 单节点                 | `sonatype/nexus3:3.66.0`     | 8081        | `:8081`  |
| [Verdaccio](docker-compose/verdaccio-single) | 单节点（NPM 私有仓库） | `verdaccio/verdaccio:6.1.5`  | 4873        | `:4873`  |

### 地理空间

| 环境                                         | 类型   | 镜像                          | 端口 | Web 界面          |
| -------------------------------------------- | ------ | ----------------------------- | ---- | ----------------- |
| [GeoServer](docker-compose/geoserver-single) | 单节点 | `oscarfonts/geoserver:2.27.1` | 8080 | `:8080/geoserver` |

### 服务发现

| 环境                                         | 类型                    | 镜像            | 端口      | Web 界面               |
| -------------------------------------------- | ----------------------- | --------------- | --------- | ---------------------- |
| [ZooKeeper](docker-compose/zookeeper-single) | 单节点 / 集群（3 节点） | `zookeeper:3.5` | 2181–2183 | ZooNavigator @ `:9000` |

### AI / 机器学习

| 环境                                                            | 类型               | 镜像                                         | 端口 | Web 界面 |
| --------------------------------------------------------------- | ------------------ | -------------------------------------------- | ---- | -------- |
| [Stable Diffusion WebUI](docker-compose/stable-diffusion-webui) | 单节点（需要 GPU） | `universonic/stable-diffusion-webui:minimal` | 8080 | `:8080`  |

## 目录结构

每个环境采用统一的布局：

```bash
environment-name/
├── README.md          # 该环境的专属文档
├── bin/
│   ├── up.sh          # 启动脚本（docker compose up -d）
│   └── down.sh        # 停止脚本（docker compose down）
└── compose/
    └── docker-compose.yml  # Docker Compose 配置
```

## 约定

- **默认凭证** — 用户名：`hz_9`，密码：`123456`
- **数据卷** — 持久化数据存放在各环境目录下的 `temp/` 中（需加载到当前目录的配置文件除外）
- **项目名称** — 每个 Compose 项目使用环境目录名作为 `-p` 项目名称

## 环境要求

- Docker Engine（含 Compose 插件）

## 许可证

MIT — 详见 [LICENSE](LICENSE) 文件。

# 容器环境集合

用于快速搭建开发环境的Docker Compose配置集合。

## 概述

本项目提供了各种常用于开发环境的服务和应用程序的即用型Docker Compose配置。每个配置都设计为简单易用，并提供标准化的启动和停止脚本。

## 可用环境

以下容器环境可用：

### 数据库系统

- **MongoDB** (单节点和多节点配置)
- **PostGIS** (单节点和多节点配置)

### 消息队列

- **Kafka** (单节点和集群配置)
- **RabbitMQ** (单节点和集群配置)

### 搜索引擎

- **Elasticsearch** (单节点和集群配置)
- **ELK Stack** (Elasticsearch, Logstash, Kibana集群，带有Filebeat和Metricbeat)

### 存储解决方案

- **MinIO** (单节点配置)

### CI/CD和仓库管理

- **Jenkins** (单节点配置)
- **Nexus** (单节点配置)
- **Verdaccio** (单节点配置 - NPM注册表)

### 地理空间

- **GeoServer** (单节点配置)

### 服务发现

- **ZooKeeper** (单节点和集群配置)

## 使用方法

每个环境都包含在自己的目录中，具有以下结构：

```bash
environment-name/
├── README.md          # 此环境的特定文档
├── bin/
│   ├── up.sh          # 启动环境的脚本
│   └── down.sh        # 停止环境的脚本
└── compose/
    └── docker-compose.yml  # Docker Compose配置
```

### 启动环境

要启动环境，请导航到环境目录并运行up脚本：

```bash
cd docker-compose/environment-name
./bin/up.sh
```

### 停止环境

要停止环境，请导航到环境目录并运行down脚本：

```bash
cd docker-compose/environment-name
./bin/down.sh
```

## 要求

- Docker Engine
- Docker Compose

## 许可证

此项目根据MIT许可证授权 - 有关详细信息，请参阅LICENSE文件。

## 贡献

欢迎贡献！请随时提交Pull Request。
