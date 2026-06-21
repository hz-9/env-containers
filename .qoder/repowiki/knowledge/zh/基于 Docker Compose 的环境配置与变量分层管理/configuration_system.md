该仓库采用 **Docker Compose** 作为核心的环境编排与配置加载工具，通过标准化的目录结构和环境变量文件实现配置的模块化管理。

### 1. 核心配置体系
*   **环境变量驱动 (`.env`)**：每个服务组件（如 `elasticsearch-single`, `elk-cluster`）根目录下均包含 `.env` 文件。这是配置的第一层，用于定义敏感信息（密码、密钥）、版本控制（`STACK_VERSION`）、端口映射及资源限制（内存）。
*   **编排定义 (`docker-compose.yml`)**：位于各组件的 `compose/` 子目录中。这些文件通过 `${VARIABLE}` 语法引用同级或上级目录 `.env` 中的变量，实现了配置值与编排逻辑的解耦。
*   **应用级配置文件**：对于复杂中间件（如 ELK, Verdaccio），使用原生 YAML/Conf 格式的配置模板（如 `filebeat.yml`, `logstash.conf`, `config.yaml`）。这些文件通常挂载到容器内部，并支持在内部再次引用环境变量（如 Logstash 中的 `${ELASTIC_HOSTS}`）。

### 2. 配置分层与加载逻辑
1.  **全局/局部变量层**：Docker Compose 自动加载当前目录下的 `.env` 文件。
2.  **服务注入层**：`docker-compose.yml` 将 `.env` 中的变量映射为容器的 `environment` 属性或直接用于 `ports`、`image` 标签。
3.  **文件挂载层**：通过 `volumes` 将宿主机的配置文件（如 `haproxy.cfg`, `metricbeat.yml`）挂载至容器指定路径，覆盖默认配置。

### 3. 关键约定与安全实践
*   **敏感信息管理**：密码和加密密钥统一存放在 `.env` 文件中，严禁硬编码在 `docker-compose.yml` 或应用配置文件中。
*   **标准化目录结构**：
    *   `<service-name>/`: 组件根目录。
    *   `<service-name>/.env`: 环境变量定义。
    *   `<service-name>/compose/docker-compose.yml`: 编排入口。
    *   `<service-name>/bin/up.sh|down.sh`: 封装好的启停脚本，简化操作。
    *   `<service-name>/temp/`: 用于持久化数据或存放运行时生成的证书/配置。
*   **网络隔离**：每个 `docker-compose.yml` 通常定义独立的 `networks`（如 `hz_9` 或 `elastic`），确保服务间的网络隔离与按需互通。

### 4. 开发者指南
*   **修改配置**：若需调整端口、密码或版本，请直接编辑对应组件根目录下的 `.env` 文件。
*   **自定义应用行为**：若需修改中间件的深层逻辑（如 Filebeat 的采集路径），请编辑对应的 `.yml` 或 `.conf` 模板文件，并确保其在 `docker-compose.yml` 中被正确挂载。
*   **新增组件**：遵循现有目录规范，创建独立的文件夹，包含 `.env`、`compose/` 目录及必要的配置文件模板。