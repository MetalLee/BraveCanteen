# MVP 项目状态

状态：草案  
上级索引：[[design/README|Design Knowledge Base]]

## 目的

记录 MVP 当前状态、已确认范围和下一步实现焦点。

## 当前状态

截至 2026-06-26：

- 设计知识库已初始化。
- 游戏定位确认为模拟经营 + 增量 + 自动战斗。
- 首版核心闭环已定义：金币 -> 食材 -> 菜品 -> 勇者属性 -> 魔物讨伐 -> 奖励 -> 餐厅成长。

截至 2026-06-29：

- 已生成 Godot 4.x MVP 原型工程，入口为 `game/project.godot`。
- 已实现最小闭环：购买食材、制作菜品、喂养勇者、派遣讨伐、自动战斗、领取奖励。
- 已加入餐厅等级 2 解锁、食谱解锁、战利品被动和本地保存读取。
- 当前环境未检测到 Godot 命令行，尚未完成引擎启动校验。

## 下一步建议

1. 用 Godot 4.x 打开 `game/project.godot`，完成启动校验。
2. 将规则层继续拆分为独立脚本模块，减少主界面脚本职责。
3. 为自动战斗、资源消耗和奖励结算补充测试或调试场景。
4. 将内容数据从 `game/data/game_data.gd` 迁移为 JSON、CSV 或 Godot Resource。
5. 打磨主界面布局、视觉反馈和战斗结果展示。

当前首版实现整理见 [[design/07_production/04_mvp_implementation_plan|MVP 实现方案]]。

## 已确认非目标

- 首版不做复杂餐厅动线。
- 首版不做手动战斗。
- 首版不做大型叙事。
- 首版不做在线功能。

## 关联文档

- [[design/07_production/00_roadmap_milestones|开发路线图与里程碑]]
- [[design/00_product/03_scope_and_success_criteria|项目范围与成功标准]]
- [[design/07_production/04_mvp_implementation_plan|MVP 实现方案]]

