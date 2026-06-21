# MongoDB副本集环境

<cite>
**本文档引用的文件**
- [docker-compose.yml（单实例）](file://docker-compose/mongodb-single/compose/docker-compose.yml)
- [docker-compose.yml（多实例）](file://docker-compose/mongodb-multi/compose/docker-compose.yml)
- [启动脚本（单实例）](file://docker-compose/mongodb-single/bin/up.sh)
- [停止脚本（单实例）](file://docker-compose/mongodb-single/bin/down.sh)
- [启动脚本（多实例）](file://docker-compose/mongodb-multi/bin/up.sh)
- [停止脚本（多实例）](file://docker-compose/mongodb-multi/bin/down.sh)
- [单实例使用说明](file://docker-compose/mongodb-single/README.md)
- [多实例使用说明](file://docker-compose/mongodb-multi/README.md)
- [环境总览文档](file://docs/README.md)
- [项目总览](file://env-containers/README.md)
</cite>

## 目录
1. [简介](#简介)
2. [项目结构](#项目结构)
3. [核心组件](#核心组件)
4. [架构概览](#架构概览)
5. [详细组件分析](#详细组件分析)
6. [依赖关系分析](#依赖关系分析)
7. [性能考虑](#性能考虑)
8. [故障排查指南](#故障排查指南)
9. [结论](#结论)
10. [附录](#附录)

## 简介
本项目提供基于Docker Compose的MongoDB副本集环境，支持单实例与三节点副本集两种部署形态，用于开发与测试场景。通过标准化的目录结构与启动/停止脚本，快速搭建可持久化的MongoDB副本集，便于进行高可用性验证、读写分离与故障转移演练。

## 项目结构
- 每个环境采用统一布局：环境根目录下包含使用说明文档、bin目录中的启动/停止脚本、以及compose目录中的Docker Compose编排文件。
- 单实例与多实例环境共享相同的项目约定：默认凭据、数据卷路径、Compose项目名等。
- 多实例副本集通过同一自定义桥接网络实现容器间互通，便于后续扩展为真实副本集拓扑。

```mermaid
graph TB
subgraph "MongoDB单实例环境"
S1["服务: mongodb<br/>端口映射: 27017:27017<br/>网络别名: all.mongodb"]
D1["数据卷: ./temp/data:/data/db"]
end
subgraph "MongoDB多实例环境"
P1["服务: mongodb-1<br/>端口映射: 27017:27017<br/>网络别名: all.mongodb1"]
R1["服务: mongodb-2<br/>端口映射: 27018:27017<br/>网络别名: all.mongodb2"]
R2["服务: mongodb-3<br/>端口映射: 27019:27017<br/>网络别名: all.mongodb3"]
D2["数据卷: ./temp/db-1到db-3/data:/data/db"]
end
S1 --- D1
P1 --- D2
R1 --- D2
R2 --- D2
```

图表来源
- [docker-compose.yml（单实例）:1-21](file://docker-compose/mongodb-single/compose/docker-compose.yml#L1-L21)
- [docker-compose.yml（多实例）:1-55](file://docker-compose/mongodb-multi/compose/docker-compose.yml#L1-L55)

章节来源
- [环境总览文档:71-83](file://docs/README.md#L71-L83)
- [单实例使用说明:1-95](file://docker-compose/mongodb-single/README.md#L1-L95)
- [多实例使用说明:1-107](file://docker-compose/mongodb-multi/README.md#L1-L107)

## 核心组件
- 容器镜像与版本
  - 使用官方MongoDB镜像：mongo:4.0-xenial，满足副本集特性要求。
- 默认凭据
  - 数据库名称：hz_9
  - 用户名：hz_9
  - 密码：123456
  - 认证数据库：admin
- 网络与互通
  - 统一使用自定义桥接网络all，容器通过网络别名相互访问。
- 数据持久化
  - 单实例：temp/data
  - 多实例：temp/db-1、db-2、db-3下的独立data目录
- 启停脚本
  - 统一以Compose项目名区分环境，便于并行管理多个环境。

章节来源
- [docker-compose.yml（单实例）:1-21](file://docker-compose/mongodb-single/compose/docker-compose.yml#L1-L21)
- [docker-compose.yml（多实例）:1-55](file://docker-compose/mongodb-multi/compose/docker-compose.yml#L1-L55)
- [单实例使用说明:66-81](file://docker-compose/mongodb-single/README.md#L66-L81)
- [多实例使用说明:78-93](file://docker-compose/mongodb-multi/README.md#L78-L93)

## 架构概览
该仓库提供了“多实例”形态的副本集拓扑示例：三个容器分别暴露不同宿主端口，均加入同一自定义网络，具备容器间互访能力。在实际生产中，可在现有基础上进一步配置副本集成员、仲裁者与选举策略，以实现主从复制与自动故障转移。

```mermaid
graph TB
subgraph "宿主机网络"
H["宿主机: 27017/27018/27019 -> 容器:27017"]
end
subgraph "Docker网络: all"
N1["all.mongodb1"]
N2["all.mongodb2"]
N3["all.mongodb3"]
end
subgraph "容器"
C1["mongodb-1"]
C2["mongodb-2"]
C3["mongodb-3"]
end
H --> C1
H --> C2
H --> C3
C1 --> N1
C2 --> N2
C3 --> N3
```

图表来源
- [docker-compose.yml（多实例）:1-55](file://docker-compose/mongodb-multi/compose/docker-compose.yml#L1-L55)

## 详细组件分析

### 单实例组件分析
- 配置要点
  - 单容器对外提供27017端口映射，便于本地直连。
  - 使用MONGO_INITDB_*环境变量完成首次初始化与认证用户创建。
- 连接方式
  - 外部直连：mongodb://hz_9:123456@127.0.0.1:27017/hz_9?authSource=admin
  - 容器内互访：mongodb://hz_9:123456@all.mongodb:27017/hz_9?authSource=admin

```mermaid
sequenceDiagram
participant U as "用户/应用"
participant H as "宿主机 : 27017"
participant C as "容器 : mongodb"
participant N as "网络 : all.mongodb"
U->>H : "连接 mongodb : //...@127.0.0.1 : 27017"
H->>C : "端口转发至27017"
C-->>U : "认证与业务响应"
U->>N : "或通过网络别名访问"
```

图表来源
- [docker-compose.yml（单实例）:1-21](file://docker-compose/mongodb-single/compose/docker-compose.yml#L1-L21)
- [单实例使用说明:13-28](file://docker-compose/mongodb-single/README.md#L13-L28)

章节来源
- [docker-compose.yml（单实例）:1-21](file://docker-compose/mongodb-single/compose/docker-compose.yml#L1-L21)
- [单实例使用说明:13-28](file://docker-compose/mongodb-single/README.md#L13-L28)

### 多实例组件分析
- 配置要点
  - 三个容器分别映射27017/27018/27019端口，便于并行演示与测试。
  - 均加入自定义网络all并配置网络别名，支持容器内互访。
- 连接方式
  - 外部直连：分别指向对应宿主端口
  - 容器内互访：通过all.mongodb1/2/3别名访问
- 初始化与认证
  - 通过MONGO_INITDB_*环境变量完成初始化与认证用户创建

```mermaid
sequenceDiagram
participant U as "用户/应用"
participant H1 as "宿主机 : 27017"
participant H2 as "宿主机 : 27018"
participant H3 as "宿主机 : 27019"
participant C1 as "容器 : mongodb-1"
participant C2 as "容器 : mongodb-2"
participant C3 as "容器 : mongodb-3"
U->>H1 : "连接实例1"
U->>H2 : "连接实例2"
U->>H3 : "连接实例3"
H1->>C1 : "端口转发"
H2->>C2 : "端口转发"
H3->>C3 : "端口转发"
```

图表来源
- [docker-compose.yml（多实例）:1-55](file://docker-compose/mongodb-multi/compose/docker-compose.yml#L1-L55)
- [多实例使用说明:15-37](file://docker-compose/mongodb-multi/README.md#L15-L37)

章节来源
- [docker-compose.yml（多实例）:1-55](file://docker-compose/mongodb-multi/compose/docker-compose.yml#L1-L55)
- [多实例使用说明:15-37](file://docker-compose/mongodb-multi/README.md#L15-L37)

### 副本集初始化与成员管理（概念说明）
当前仓库未直接提供副本集初始化脚本，但已具备容器网络与数据持久化基础。以下为在现有环境中构建副本集的通用步骤（概念性说明，非仓库内具体实现）：

- 初始化副本集
  - 在任一容器中进入mongo客户端，执行副本集初始化命令。
- 添加成员
  - 将其他容器作为副本成员加入副本集；根据需要配置隐藏节点、延迟节点与仲裁者。
- 选举与故障转移
  - 主节点故障时由剩余成员重新选举；仲裁者不参与数据投票但参与仲裁。
- 成员移除
  - 先降级再移除成员，确保副本集多数派仍可达。

```mermaid
flowchart TD
Start(["开始"]) --> Init["初始化副本集"]
Init --> AddMembers["添加副本成员"]
AddMembers --> Healthy{"多数派可达？"}
Healthy --> |否| Fix["修复网络/成员状态"]
Healthy --> |是| Run["正常运行"]
Run --> Fail{"主节点故障？"}
Fail --> |否| Run
Fail --> |是| Elect["重新选举主节点"]
Elect --> Run
```

（本图为概念流程图，无需图表来源）

### 连接字符串、读写偏好与一致性（概念说明）
- 连接字符串
  - 单实例：mongodb://hz_9:123456@127.0.0.1:27017/hz_9?authSource=admin
  - 多实例：分别对应各宿主端口
- 读写偏好
  - 写操作建议路由至主节点
  - 读操作可路由至从节点，需结合业务对一致性的需求
- 一致性级别
  - 本地强一致性适合单实例
  - 副本集场景建议结合业务权衡最终一致与读写偏好

（本节为概念性说明，无需章节来源）

### 监控、健康检查、备份与灾备（概念说明）
- 健康检查
  - 可通过MongoDB内置状态命令检查副本集成员状态
- 监控
  - 结合外部监控系统采集副本集指标
- 备份
  - 使用逻辑导出工具定期备份；生产环境建议结合快照与增量备份策略
- 灾难恢复
  - 制定成员离线/重建流程，确保多数派可达与数据一致性

（本节为概念性说明，无需章节来源）

## 依赖关系分析
- 组件耦合
  - 容器镜像版本固定为mongo:4.0-xenial，保证副本集特性兼容性。
  - 网络与数据卷为容器运行的基础依赖。
- 外部依赖
  - Docker Engine与Compose插件为运行前提。
- 项目约定
  - 所有环境遵循统一的目录结构与脚本命名规范，降低维护成本。

```mermaid
graph LR
A["docs/README.md<br/>环境总览"] --> B["mongodb-single<br/>单实例环境"]
A --> C["mongodb-multi<br/>多实例环境"]
B --> B1["compose/docker-compose.yml"]
B --> B2["bin/up.sh / down.sh"]
C --> C1["compose/docker-compose.yml"]
C --> C2["bin/up.sh / down.sh"]
```

图表来源
- [环境总览文档:71-83](file://docs/README.md#L71-L83)
- [单实例使用说明:1-95](file://docker-compose/mongodb-single/README.md#L1-L95)
- [多实例使用说明:1-107](file://docker-compose/mongodb-multi/README.md#L1-L107)

章节来源
- [环境总览文档:71-83](file://docs/README.md#L71-L83)

## 性能考虑
- 磁盘与I/O
  - 使用独立数据卷目录，避免跨实例I/O争用
- 网络
  - 容器间通信通过自定义网络，减少跨主机开销
- 资源限制
  - 生产环境建议为容器设置CPU/内存限制，防止资源抢占
- 版本与特性
  - 使用4.0版本镜像，确保副本集相关特性可用

（本节为通用指导，无需章节来源）

## 故障排查指南
- 端口占用
  - 多实例模式需确保27017-27019端口未被占用
- 权限问题
  - 确认连接字符串中的authSource与认证数据库一致
- 数据持久化
  - 停止后数据卷保留于temp目录，重启后可继续使用
- 日志与状态
  - 使用Compose状态命令检查容器运行状态

章节来源
- [多实例使用说明:101-107](file://docker-compose/mongodb-multi/README.md#L101-L107)
- [单实例使用说明:89-95](file://docker-compose/mongodb-single/README.md#L89-L95)

## 结论
本仓库提供了标准化的MongoDB单实例与多实例部署模板，具备良好的可移植性与可扩展性。在此基础上，可进一步引入副本集初始化脚本、仲裁者配置与自动化运维工具，以满足更复杂的高可用与容灾需求。

## 附录
- 快速上手
  - 进入环境目录，执行启动脚本即可运行
- 停止与清理
  - 执行停止脚本，数据卷默认保留，便于下次启动复用

章节来源
- [环境总览文档:14-14](file://docs/README.md#L14-L14)
- [启动脚本（单实例）:1-23](file://docker-compose/mongodb-single/bin/up.sh#L1-L23)
- [停止脚本（单实例）:1-20](file://docker-compose/mongodb-single/bin/down.sh#L1-L20)
- [启动脚本（多实例）:1-25](file://docker-compose/mongodb-multi/bin/up.sh#L1-L25)
- [停止脚本（多实例）:1-20](file://docker-compose/mongodb-multi/bin/down.sh#L1-L20)