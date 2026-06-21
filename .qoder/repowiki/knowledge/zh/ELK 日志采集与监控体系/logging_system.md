该仓库本身不包含应用程序代码，而是一个容器化开发环境编排中心。其“日志系统”主要体现在 `docker-compose/elk-cluster` 模块中，提供了一套基于 **ELK Stack (Elasticsearch, Logstash, Kibana)** 结合 **Beats (Filebeat, Metricbeat)** 的标准化日志采集、处理与可视化方案。

### 1. 核心架构与组件
- **Elasticsearch**: 作为日志存储与检索引擎，负责持久化所有采集到的日志数据。
- **Logstash**: 作为日志处理管道，支持从文件（如 CSV）读取数据，经过过滤处理后写入 Elasticsearch。配置示例位于 `docker-compose/elk-cluster/logstash/logstash.conf`。
- **Kibana**: 提供日志可视化界面，用于查询、分析和展示 Elasticsearch 中的数据。
- **Filebeat**: 轻量级日志采集器，配置为监控 Docker 容器日志及指定路径下的文件日志（`*.log`），并自动添加 Docker 元数据。配置位于 `docker-compose/elk-cluster/filebeat/filebeat.yml`。
- **Metricbeat**: 用于采集系统及服务指标（如 Elasticsearch, Kibana, Docker 容器状态），并发送至 Elasticsearch。配置位于 `docker-compose/elk-cluster/metricbeat/metricbeat.yml`。

### 2. 日志流向与约定
- **采集层**: Filebeat 通过挂载 Docker Socket (`/var/run/docker.sock`) 自动发现并采集容器标准输出日志，同时监控 `ingest_data` 目录下的文件日志。
- **处理层**: Logstash 主要用于批量数据导入场景（如 CSV 文件），支持 `mode => "read"` 一次性读取并记录完成状态。
- **存储层**: 所有日志统一索引至 Elasticsearch，索引模式通常按日期划分（如 `logstash-%{+YYYY.MM.dd}`）。
- **安全与网络**: 组件间通信启用 SSL/TLS 加密，通过 `certs` 卷共享 CA 证书，确保日志传输安全。

### 3. 开发者指南
- **启动日志栈**: 进入 `docker-compose/elk-cluster` 目录，执行 `bin/up.sh` 即可启动完整的 ELK 集群。
- **查看日志**: 可通过 Kibana Web UI (默认端口 5601) 进行可视化查询，或直接使用 `docker compose logs` 查看各组件运行状态。
- **扩展采集**: 若需采集新服务的日志，可在 Filebeat 配置中添加新的 `filestream` 输入源，或利用 Docker label (`co.elastic.logs/module`) 进行自动标记。

### 4. 关键文件
- `docker-compose/elk-cluster/compose/docker-compose.yml`: 定义 ELK 集群及 Beats 的服务编排。
- `docker-compose/elk-cluster/filebeat/filebeat.yml`: Filebeat 输入输出及处理器配置。
- `docker-compose/elk-cluster/logstash/logstash.conf`: Logstash 管道处理逻辑。
- `docker-compose/elk-cluster/metricbeat/metricbeat.yml`: 指标采集模块配置。