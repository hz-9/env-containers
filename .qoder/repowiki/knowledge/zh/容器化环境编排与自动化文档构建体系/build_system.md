## 1. 核心构建与编排策略
该项目采用 **Docker Compose** 作为核心的基础设施编排工具，通过标准化的目录结构和 Shell 脚本实现中间件（如 Elasticsearch, Kafka, MongoDB 等）的“一键式”启停。在文档站点方面，项目集成了 **VuePress 2** 静态站点生成器，并配合自定义的 `@hz-9/docs-build` 工具链，实现了从配置到文档页面的自动化生成与部署。

## 2. 关键文件与组件
*   **CI/CD 流水线**: `.github/workflows/generate-pages.yml` 定义了完整的自动化流程，包括页面生成、依赖安装、静态资源构建以及向 GitHub Pages 的部署。
*   **自动化脚本**: `scripts/generate-pages.sh` 负责调用 `npx @hz-9/docs-build` 根据 `docs-build.config.json` 动态生成 VuePress 所需的源文件结构。
*   **服务启停规范**: 每个服务目录下均包含 `bin/up.sh` 和 `bin/down.sh`，利用 `docker compose` 命令结合 `.env` 环境变量文件进行容器生命周期管理。
*   **文档构建配置**: `docs/.vuepress/package.json` 明确了 VuePress 及其主题 `vuepress-theme-hope` 的版本依赖；`docs-build.config.json` 则定义了多语言支持（en-US, zh-CN）及导航栏/侧边栏的逻辑映射。

## 3. 架构约定与设计模式
*   **标准化服务目录结构**: 所有 Docker Compose 方案遵循统一的层级：
    *   `compose/docker-compose.yml`: 核心编排定义。
    *   `bin/{up,down}.sh`: 封装了复杂的 `docker compose` 参数（如 `-p` 项目名、`--env-file` 路径），提供简洁的操作入口。
    *   `.env`: 集中管理服务凭证、端口映射及版本变量。
*   **文档即代码 (Docs as Code)**: 通过 `generate-pages.sh` 将分散的 Markdown 说明文件自动聚合为结构化的 VuePress 站点，减少了手动维护侧边栏和路由配置的负担。
*   **自动化通知机制**: CI 流程在部署完成后会通过 SMTP 协议发送电子邮件通知，确保团队成员知晓文档更新状态。

## 4. 开发者操作指南
*   **启动服务**: 进入对应服务的 `bin` 目录执行 `./up.sh`，或通过 `docker compose -p <project-name> up -d` 手动启动。
*   **文档本地调试**: 在 `docs/.vuepress` 目录下运行 `npm run docs:dev` 即可预览实时更新的文档站点。
*   **环境隔离**: 建议在使用不同服务时注意 `.env` 文件中定义的端口冲突问题，并通过 `docker compose ps` 监控容器健康状态。