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
