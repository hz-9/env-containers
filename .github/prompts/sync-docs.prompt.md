---
mode: 'agent'
model: Claude Sonnet 3.7
description: '同步仓库文档'
---

# 文档同步任务

请在后续任务中，注意以下内容：

- 翻译文件时，如果中英两个版本都存在时，请先全部阅读；
- 如果中英文版本内容不一致，请优先以中文版本为准；
- 如果进行翻译时，请不要忘记删除历史版本的内容；
- 如果处理过程中，哪个步骤失败了，请再次尝试；

请按照顺序依次完成下列任务：

- 1 `docs/README.zh-CN.md` 与 `docs/README.md` 文档；
  - 1.1 以 `docs/README.zh-CN.md` 文档为主；
  - 1.2 将 `docs/README.zh-CN.md` 文档内容翻译为英文，保存为 `docs/README.md` 文档；
  - 1.3 在翻译过程中，请基于当前的 `docs/README.md` 的内容进行调整，仅对当前内容不匹配的部分进行重新翻译；

- 2 `docs/overview/testing.zh-CN.md` 与 `docs/overview/testing.md` 文档；
  - 2.1 以 `docs/overview/testing.zh-CN.md` 文档为主；
  - 2.2 读取 `docs/overview/testing.zh-CN.md` 文档内容，如果有疏漏或错误，进行修正；
  - 2.3 修正时，请基于 `docs/overview/testing.zh-CN.md` 已存在的内容进行改造；
  - 2.4 将 `docs/overview/testing.zh-CN.md` 文档内容翻译为英文，保存为 `docs/overview/testing.md` 文档；

- 3 `docs/overview/directory-structure.zh-CN.md` 与 `docs/overview/directory-structure.md` 文档；
  - 3.1 以 `docs/overview/directory-structure.zh-CN.md` 文档为主；
  - 3.2 读取 `docs/overview/directory-structure.zh-CN.md` 文档内容，如果有疏漏或错误，进行修正；
  - 3.3 忽略 `.gitignore` 文件中的路径，扫描当前项目目录结构；
  - 3.4 因为扫描结果过大，可以分段将当前项目目录结构同步到 `docs/overview/directory-structure.zh-CN.md` 文档中；
  - 3.5 同步时，请基于 `docs/overview/directory-structure.zh-CN.md` 已存在的内容进行改造；
  - 3.6 将 `docs/overview/directory-structure.zh-CN.md` 文档内容翻译为英文，保存为 `docs/overview/directory-structure.md` 文档；

- 4 `docs/overview/scripts.zh-CN.md` 与 `docs/overview/scripts.md` 文档；
  - 4.1 以 `docs/overview/scripts.zh-CN.md` 文档为主；
  - 4.2 读取 `docs/overview/scripts.zh-CN.md` 文档内容，如果有疏漏或错误，进行修正；
  - 4.3 扫描 `scripts/*.sh`，对 `docs/overview/scripts.zh-CN.md` 进行同步与升级；
  - 4.4 忽略 `scripts/__base.sh` 文件；
  - 4.5 需要包含所有脚本的示例，而非仅仅是部分脚本；
  - 4.6 同步时，请基于 `docs/overview/scripts.zh-CN.md` 已存在的内容进行改造；
  - 4.7 将 `docs/overview/scripts.zh-CN.md` 文档内容翻译为英文，保存为 `docs/overview/scripts.md` 文档；
