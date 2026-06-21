## 1. 系统与方法论
该仓库的前端样式主要服务于文档站点（`docs/`），基于 **VuePress 2** 构建，并采用了 **vuepress-theme-hope** 作为核心主题。样式管理遵循 SCSS 预处理器规范，通过主题提供的钩子文件进行定制化配置。

- **核心框架**: VuePress 2 + vuepress-theme-hope
- **CSS 预处理器**: SCSS (Sass)，通过 `sass-embedded` 和 Vite bundler 集成。
- **图标系统**: 使用 FontAwesome 图标集（通过 `@vuepress/plugin-icon` 集成）。

## 2. 关键文件与配置
样式相关的核心逻辑集中在 `docs/.vuepress/src/.vuepress/` 目录下：

- **`styles/palette.scss`**: 定义全局主题色。目前主色调设置为 `$theme-color: #096dd9;`（Ant Design 蓝）。
- **`styles/config.scss`**: 定义辅助颜色变量 `$colors`，用于生成不同状态或类别的样式标记。
- **`styles/index.scss`**: 入口样式文件，用于注入全局自定义 CSS。当前包含针对 PC 端内容宽度的媒体查询调整，以及隐藏正文第一个段落的特定规则。
- **`theme.ts`**: 主题配置文件，初始化 `hopeTheme` 并启用 `icon` 插件。
- **`config.ts`**: 站点配置文件，其中配置了 Vite 的 SCSS 预处理选项，显式禁用了 `import` 弃用警告 (`silenceDeprecations: ['import']`)。

## 3. 架构与约定
- **样式覆盖策略**: 采用 SCSS 变量覆盖（Palette/Config）与全局样式注入（Index）相结合的方式。开发者应优先在 `palette.scss` 中修改主题色，在 `index.scss` 中处理布局微调或组件覆盖。
- **响应式设计**: 依赖 `vuepress-theme-hope` 内置的响应式断点（如 `hope-config.$pc`）。自定义样式需遵循主题的断点系统以确保多端一致性。
- **模块化**: 样式文件按功能拆分（调色板、配置、全局样式），保持配置的可维护性。

## 4. 开发规范
- **变量优先**: 修改颜色或间距时，优先使用 `palette.scss` 和 `config.scss` 中定义的 SCSS 变量，避免硬编码颜色值。
- **SCSS 语法**: 使用 `@use` 而非已弃用的 `@import` 引入模块（如 `@use '@sass-palette/hope-config';`）。
- **布局调整**: 若需调整内容区域宽度或边距，应在 `index.scss` 中通过 CSS 变量（如 `--content-width`）或媒体查询进行覆盖。
- **图标使用**: 在 Markdown 或组件中使用图标时，应引用 FontAwesome 的标准类名或主题支持的图标标识符。