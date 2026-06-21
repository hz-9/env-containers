# RabbitMQ单实例配置

<cite>
**本文档引用的文件**
- [docker-compose.yml](file://docker-compose/rabbitmq-single/compose/docker-compose.yml)
- [up.sh](file://docker-compose/rabbitmq-single/bin/up.sh)
- [down.sh](file://docker-compose/rabbitmq-single/bin/down.sh)
- [README.md](file://docker-compose/rabbitmq-single/README.md)
</cite>

## 目录
1. [简介](#简介)
2. [项目结构](#项目结构)
3. [核心组件](#核心组件)
4. [架构概览](#架构概览)
5. [详细组件分析](#详细组件分析)
6. [依赖关系分析](#依赖关系分析)
7. [性能考虑](#性能考虑)
8. [故障排除指南](#故障排除指南)
9. [结论](#结论)

## 简介

本文件提供了RabbitMQ单实例环境的完整配置文档。该配置实现了基于Docker Compose的单容器RabbitMQ部署，包含完整的消息队列服务、Web管理界面和Prometheus监控功能。文档详细说明了容器镜像选择、端口映射、环境变量配置、数据持久化策略以及健康检查机制，并提供了启动脚本使用方法和停止清理流程。

## 项目结构

RabbitMQ单实例项目的目录结构采用标准的Docker Compose组织方式：

```mermaid
graph TB
subgraph "RabbitMQ单实例项目结构"
Root[项目根目录]
subgraph "compose目录"
ComposeFile[docker-compose.yml]
ConfigDir[配置文件]
end
subgraph "bin目录"
UpScript[up.sh 启动脚本]
DownScript[down.sh 停止脚本]
end
subgraph "其他文件"
Readme[README.md 文档]
end
Root --> ComposeFile
Root --> UpScript
Root --> DownScript
Root --> Readme
end
```

**图表来源**
- [docker-compose.yml:1-38](file://docker-compose/rabbitmq-single/compose/docker-compose.yml#L1-L38)
- [up.sh:1-55](file://docker-compose/rabbitmq-single/bin/up.sh#L1-L55)
- [down.sh:1-23](file://docker-compose/rabbitmq-single/bin/down.sh#L1-L23)

**章节来源**
- [docker-compose.yml:1-38](file://docker-compose/rabbitmq-single/compose/docker-compose.yml#L1-L38)
- [README.md:1-233](file://docker-compose/rabbitmq-single/README.md#L1-L233)

## 核心组件

### 容器配置

RabbitMQ单实例容器配置包含以下关键组件：

#### 镜像选择
- **基础镜像**: `rabbitmq:4.1.2-management`
- **版本特性**: 包含管理界面插件和Prometheus监控支持

#### 网络配置
- **网络名称**: `all`
- **网络类型**: Bridge网络
- **容器别名**: `all.rabbitmq`
- **主机名**: `rabbitmq-single`

#### 存储卷配置
- **数据卷**: `/var/lib/rabbitmq` → `../temp/data`
- **日志卷**: `/var/log/rabbitmq` → `../temp/logs`
- **配置卷**: `/etc/rabbitmq` → `../temp/config`

#### 端口映射
- **AMQP端口**: 5672:5672 (消息传输协议)
- **管理端口**: 15672:15672 (Web管理界面)
- **监控端口**: 15692:15692 (Prometheus指标)

**章节来源**
- [docker-compose.yml:2-38](file://docker-compose/rabbitmq-single/compose/docker-compose.yml#L2-L38)

### 环境变量配置

系统通过环境变量进行配置管理：

#### 用户认证配置
- `RABBITMQ_DEFAULT_USER`: 默认用户名 `hz_9`
- `RABBITMQ_DEFAULT_PASS`: 默认密码 `123456`

#### 节点配置
- `RABBITMQ_NODENAME`: 节点名称 `rabbit@rabbitmq-single`

#### 管理界面配置
- `RABBITMQ_MANAGEMENT_ALLOW_WEB_ACCESS`: 允许Web访问 `true`

#### 虚拟主机配置
- `RABBITMQ_DEFAULT_VHOST`: 默认虚拟主机 `/`

**章节来源**
- [docker-compose.yml:15-25](file://docker-compose/rabbitmq-single/compose/docker-compose.yml#L15-L25)

## 架构概览

RabbitMQ单实例部署采用简洁的一层架构设计：

```mermaid
graph TB
subgraph "客户端层"
ClientApps[应用程序]
MonitoringTools[监控工具]
end
subgraph "RabbitMQ单实例容器"
RabbitMQ[RabbitMQ服务]
subgraph "内部组件"
AMQP[AMQP协议处理]
Management[管理界面]
Prometheus[Prometheus监控]
Plugins[插件系统]
end
subgraph "存储层"
DataVolume[数据卷]
LogVolume[日志卷]
ConfigVolume[配置卷]
end
end
subgraph "网络层"
BridgeNet[Bridge网络]
HostPorts[主机端口映射]
end
ClientApps --> AMQP
MonitoringTools --> Prometheus
RabbitMQ --> AMQP
RabbitMQ --> Management
RabbitMQ --> Prometheus
RabbitMQ --> Plugins
RabbitMQ --> DataVolume
RabbitMQ --> LogVolume
RabbitMQ --> ConfigVolume
RabbitMQ --> BridgeNet
RabbitMQ --> HostPorts
```

**图表来源**
- [docker-compose.yml:1-38](file://docker-compose/rabbitmq-single/compose/docker-compose.yml#L1-L38)

## 详细组件分析

### Docker Compose配置分析

#### 服务定义详解

```mermaid
classDiagram
class RabbitMQService {
+image : "rabbitmq : 4.1.2-management"
+container_name : "rabbitmq-single"
+restart : "always"
+hostname : "rabbitmq-single"
+healthcheck : status
+volumes : 3个卷挂载
+ports : 3个端口映射
+environment : 5个环境变量
}
class VolumeMounts {
+data_volume : "/var/lib/rabbitmq"
+log_volume : "/var/log/rabbitmq"
+config_volume : "/etc/rabbitmq"
}
class PortsMapping {
+amqp_port : "5672 : 5672"
+management_port : "15672 : 15672"
+monitoring_port : "15692 : 15692"
}
class EnvironmentVariables {
+default_user : "hz_9"
+default_pass : "123456"
+node_name : "rabbit@rabbitmq-single"
+vhost : "/"
+web_access : "true"
}
RabbitMQService --> VolumeMounts
RabbitMQService --> PortsMapping
RabbitMQService --> EnvironmentVariables
```

**图表来源**
- [docker-compose.yml:2-38](file://docker-compose/rabbitmq-single/compose/docker-compose.yml#L2-L38)

#### 健康检查机制

健康检查配置确保容器运行状态的可靠性：

```mermaid
sequenceDiagram
participant Docker as Docker Engine
participant HealthCheck as HealthCheck
participant RabbitMQ as RabbitMQ Service
participant RabbitMQCtl as rabbitmqctl
Docker->>HealthCheck : 每30秒执行一次检查
HealthCheck->>RabbitMQCtl : 执行状态检查命令
RabbitMQCtl->>RabbitMQ : 查询服务状态
RabbitMQ-->>RabbitMQCtl : 返回状态信息
RabbitMQCtl-->>HealthCheck : 健康状态
HealthCheck-->>Docker : 更新容器健康状态
Note over HealthCheck : 最大重试次数 : 5次<br/>超时时间 : 10秒
```

**图表来源**
- [docker-compose.yml:29-33](file://docker-compose/rabbitmq-single/compose/docker-compose.yml#L29-L33)

**章节来源**
- [docker-compose.yml:29-33](file://docker-compose/rabbitmq-single/compose/docker-compose.yml#L29-L33)

### 启动脚本分析

#### up.sh脚本功能

启动脚本提供了自动化的部署流程：

```mermaid
flowchart TD
Start([执行up.sh]) --> SetupDirs["创建必要的目录结构"]
SetupDirs --> CreatePlugins["生成插件配置文件"]
CreatePlugins --> SetPermissions["设置文件权限"]
SetPermissions --> StartCompose["启动Docker Compose服务"]
StartCompose --> PrintInfo["显示服务访问信息"]
PrintInfo --> End([完成])
subgraph "目录创建"
SetupDirs --> DataDir["temp/data"]
SetupDirs --> LogDir["temp/logs"]
SetupDirs --> ConfigDir["temp/config"]
end
subgraph "插件配置"
CreatePlugins --> EnabledPlugins["enabled_plugins文件"]
EnabledPlugins --> PluginList["[rabbitmq_management,rabbitmq_prometheus]"]
end
```

**图表来源**
- [up.sh:14-28](file://docker-compose/rabbitmq-single/bin/up.sh#L14-L28)

#### 下载脚本功能

停止脚本提供了安全的服务终止机制：

```mermaid
flowchart TD
StopStart([执行down.sh]) --> StopServices["停止Docker Compose服务"]
StopServices --> PrintNotice["显示数据保留通知"]
PrintNotice --> End([完成])
subgraph "数据保留"
PrintNotice --> DataRetention["temp/data/ 数据保留"]
PrintNotice --> LogRetention["temp/logs/ 日志保留"]
PrintNotice --> ManualCleanup["手动删除temp目录完全清理"]
end
```

**图表来源**
- [down.sh:13-22](file://docker-compose/rabbitmq-single/bin/down.sh#L13-L22)

**章节来源**
- [up.sh:1-55](file://docker-compose/rabbitmq-single/bin/up.sh#L1-L55)
- [down.sh:1-23](file://docker-compose/rabbitmq-single/bin/down.sh#L1-L23)

### 数据持久化配置

#### 卷挂载策略

数据持久化通过三个独立的卷实现：

```mermaid
erDiagram
RabbitMQ_CONTAINER {
string var_lib_rabbitmq
string var_log_rabbitmq
string etc_rabbitmq_config
}
HOST_DIRECTORIES {
string temp_data
string temp_logs
string temp_config
}
VOLUME_MAPPING {
string data_volume_mapping
string log_volume_mapping
string config_volume_mapping
}
RabbitMQ_CONTAINER ||--|| HOST_DIRECTORIES : "挂载"
HOST_DIRECTORIES ||--|| VOLUME_MAPPING : "映射到"
note for RabbitMQ_CONTAINER "容器内路径"
note for HOST_DIRECTORIES "主机目录"
note for VOLUME_MAPPING "卷映射配置"
```

**图表来源**
- [docker-compose.yml:11-14](file://docker-compose/rabbitmq-single/compose/docker-compose.yml#L11-L14)

#### 存储卷用途

| 卷类型 | 容器内路径 | 主机映射路径 | 用途 |
|--------|------------|-------------|------|
| 数据卷 | `/var/lib/rabbitmq` | `../temp/data` | 消息持久化存储 |
| 日志卷 | `/var/log/rabbitmq` | `../temp/logs` | 运行日志记录 |
| 配置卷 | `/etc/rabbitmq` | `../temp/config` | 插件和配置文件 |

**章节来源**
- [docker-compose.yml:11-14](file://docker-compose/rabbitmq-single/compose/docker-compose.yml#L11-L14)

## 依赖关系分析

### 组件间依赖关系

```mermaid
graph TB
subgraph "外部依赖"
Docker[Docker Engine]
DockerCompose[Docker Compose]
end
subgraph "RabbitMQ单实例"
RabbitMQContainer[RabbitMQ容器]
Network[Bridge网络]
Volumes[数据卷]
end
subgraph "内部组件"
AMQPProtocol[AMQP协议]
ManagementUI[管理界面]
PrometheusMetrics[Prometheus指标]
Plugins[插件系统]
end
Docker --> DockerCompose
DockerCompose --> RabbitMQContainer
RabbitMQContainer --> Network
RabbitMQContainer --> Volumes
RabbitMQContainer --> AMQPProtocol
RabbitMQContainer --> ManagementUI
RabbitMQContainer --> PrometheusMetrics
RabbitMQContainer --> Plugins
```

**图表来源**
- [docker-compose.yml:1-38](file://docker-compose/rabbitmq-single/compose/docker-compose.yml#L1-L38)

### 环境变量依赖

系统配置依赖于以下环境变量的正确设置：

```mermaid
flowchart LR
subgraph "配置依赖链"
ImageVersion["镜像版本"] --> Plugins["插件启用"]
Plugins --> Management["管理界面"]
Plugins --> Prometheus["监控功能"]
UserConfig["用户配置"] --> Authentication["认证系统"]
Authentication --> VirtualHost["虚拟主机"]
NodeConfig["节点配置"] --> NetworkAlias["网络别名"]
NetworkAlias --> InterContainer["容器间通信"]
end
```

**图表来源**
- [docker-compose.yml:15-25](file://docker-compose/rabbitmq-single/compose/docker-compose.yml#L15-L25)

**章节来源**
- [docker-compose.yml:15-25](file://docker-compose/rabbitmq-single/compose/docker-compose.yml#L15-L25)

## 性能考虑

### 内存配置优化

根据生产环境需求，建议调整内存配置参数：

#### 内存水位线设置
- **默认值**: 40%可用RAM
- **生产推荐**: 通过 `RABBITMQ_VM_MEMORY_HIGH_WATERMARK` 参数调整
- **适用场景**: 高并发消息处理环境

#### 磁盘空间监控
- **默认阈值**: 50MB磁盘空间
- **生产推荐**: 通过 `RABBITMQ_DISK_FREE_LIMIT` 参数设置
- **监控建议**: 定期检查磁盘使用率

### 端口和服务配置

| 服务类型 | 端口号 | 用途 | 建议配置 |
|----------|--------|------|----------|
| AMQP协议 | 5672 | 消息传输 | 标准端口，无需修改 |
| 管理界面 | 15672 | Web管理 | 仅本地访问 |
| 监控指标 | 15692 | Prometheus | 仅本地访问 |

**章节来源**
- [README.md:213-224](file://docker-compose/rabbitmq-single/README.md#L213-L224)

## 故障排除指南

### 常见问题诊断

#### 启动失败问题

```mermaid
flowchart TD
StartProblem([启动问题]) --> CheckPorts["检查端口占用"]
CheckPorts --> PortConflict{"端口冲突?"}
PortConflict --> |是| FixPorts["释放端口或修改映射"]
PortConflict --> |否| CheckVolumes["检查卷权限"]
CheckVolumes --> VolumePermission{"权限不足?"}
VolumePermission --> |是| FixPermissions["修复卷权限"]
VolumePermission --> |否| CheckLogs["查看容器日志"]
FixPorts --> Restart["重新启动服务"]
FixPermissions --> Restart
CheckLogs --> AnalyzeLogs["分析错误信息"]
AnalyzeLogs --> Solution["解决问题"]
Restart --> End([完成])
Solution --> End
```

#### 连接问题排查

```mermaid
sequenceDiagram
participant Client as 客户端应用
participant RabbitMQ as RabbitMQ服务
participant Network as 网络层
participant Auth as 认证系统
Client->>RabbitMQ : 尝试建立连接
RabbitMQ->>Auth : 验证用户凭据
Auth-->>RabbitMQ : 认证结果
RabbitMQ->>Network : 检查网络连通性
Network-->>RabbitMQ : 网络状态
RabbitMQ-->>Client : 连接响应
Note over Client,RabbitMQ : 检查用户名、密码、虚拟主机配置
```

#### 监控指标获取

```mermaid
flowchart LR
subgraph "监控数据流"
Prometheus[Prometheus服务器]
RabbitMQ[容器]
MetricsEndpoint[15692端口]
Grafana[Grafana仪表板]
end
Prometheus --> MetricsEndpoint
MetricsEndpoint --> RabbitMQ
RabbitMQ --> MetricsEndpoint
MetricsEndpoint --> Prometheus
Prometheus --> Grafana
```

**章节来源**
- [README.md:186-203](file://docker-compose/rabbitmq-single/README.md#L186-L203)

### 停止和清理流程

#### 安全停止步骤

```mermaid
flowchart TD
StopCommand([执行停止命令]) --> GracefulStop["优雅停止服务"]
GracefulStop --> CheckConnections["检查活动连接"]
CheckConnections --> ForceStop{"需要强制停止?"}
ForceStop --> |否| VerifyShutdown["验证服务关闭"]
ForceStop --> |是| ForceKill["强制终止进程"]
VerifyShutdown --> CleanupVolumes["清理临时文件"]
ForceKill --> CleanupVolumes
CleanupVolumes --> Complete([完成])
```

#### 数据清理选项

| 清理级别 | 操作内容 | 影响范围 | 使用场景 |
|----------|----------|----------|----------|
| 服务停止 | 仅停止容器 | 无数据丢失 | 临时维护 |
| 数据保留 | 停止并保留卷 | 数据和配置保留 | 开发测试 |
| 完全清理 | 删除所有数据和配置 | 完全重置 | 环境重建 |

**章节来源**
- [down.sh:18-22](file://docker-compose/rabbitmq-single/bin/down.sh#L18-L22)

## 结论

RabbitMQ单实例配置提供了一个完整、可靠的单容器消息队列解决方案。该配置具有以下特点：

### 优势特性
- **简化部署**: 单容器架构，易于理解和维护
- **完整功能**: 包含管理界面和监控功能
- **数据持久化**: 三个独立卷确保数据安全
- **自动化脚本**: 提供便捷的启动和停止流程

### 适用场景
- **开发测试环境**: 快速搭建和销毁
- **小型应用**: 低复杂度的消息传递需求
- **学习研究**: 理解RabbitMQ基本概念

### 生产环境建议
考虑到单实例部署的局限性，建议在生产环境中：
- 考虑集群部署以获得高可用性
- 实施定期备份策略
- 监控资源使用情况
- 制定灾难恢复计划

该配置为RabbitMQ的使用提供了良好的起点，可根据具体需求进行扩展和优化。