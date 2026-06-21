该仓库采用**容器化编排**与**前端包管理**相结合的混合依赖管理模式，核心在于通过 Docker Compose 提供标准化的私有制品库（Nexus, Verdaccio）基础设施，并在文档站点中实践严格的版本锁定。

### 1. 系统与方法
*   **基础设施即依赖 (Infrastructure as Dependency)**：将 Nexus Repository Manager 和 Verdaccio 作为标准中间件进行容器化部署。这些服务充当企业内部的依赖代理和缓存中心，解决第三方库的下载加速、离线可用性及私有包发布问题。
*   **前端包管理 (pnpm/npm)**：文档站点 (`docs/.vuepress`) 使用 `package.json` 声明开发依赖，并通过 `package-lock.json` (Lockfile v3) 实现精确的版本锁定。脚本中使用 `pnpm dlx` 表明倾向于使用 pnpm 工具链。
*   **上游代理策略**：Verdaccio 配置了双重上游代理（npmjs 官方源与淘宝镜像 npmmirror），以优化国内网络环境下的依赖获取速度。

### 2. 关键文件与包
*   **私有注册表配置**：
    *   `docker-compose/verdaccio-single/config/config.yaml`：定义了 NPM 私有源的存储路径、认证方式（htpasswd）、上游代理（uplinks）及包权限控制（如 `@hz-9/*` 作用域）。
    *   `docker-compose/nexus-single/compose/docker-compose.yml`：部署 Sonatype Nexus 3，用于管理 Maven、Docker、PyPI 等多语言制品。
*   **前端依赖清单**：
    *   `docs/.vuepress/package.json`：声明 VuePress 2.0 RC 版本及相关主题依赖。
    *   `docs/.vuepress/package-lock.json`：记录完整的依赖树哈希值，确保构建环境的一致性。

### 3. 架构与约定
*   **多语言制品支持**：通过 Nexus 覆盖 Java (Maven)、Python (PyPI)、.NET (NuGet) 等生态；通过 Verdaccio 专注 Node.js (NPM) 生态。
*   **网络隔离与别名**：所有依赖管理服务均接入 `all` 桥接网络，并配置了统一的网络别名（如 `all.verdaccio`, `all.nexus`），便于集群内其他容器通过内部 DNS 解析访问依赖源。
*   **数据持久化**：依赖库的缓存数据与私有制品均映射至宿主机的 `temp/` 目录（如 `temp/storage`, `temp/data`），确保容器重启后依赖缓存不丢失。

### 4. 开发者规则
*   **私有包发布规范**：向 Verdaccio 发布包时，推荐使用 `@hz-9/*` 作用域，该作用域在配置中被设定为仅允许认证用户发布与撤销。
*   **环境初始化**：首次启动 Nexus 需通过 `docker exec` 获取初始 admin 密码；Verdaccio 需通过 `npm adduser` 创建首个管理员账户。
*   **依赖源切换**：在开发环境中，应通过 `npm config set registry` 或 `.npmrc` 将默认源指向本地运行的 Verdaccio 实例，以利用其缓存加速依赖安装。