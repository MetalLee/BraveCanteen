# 数据管线与工具

状态：草案  
上级索引：[[design/README|Design Knowledge Base]]

## 目的

定义内容数据格式、校验需求和工具边界。

## 数据对象

- ingredients
- recipes
- dishes
- adventurers
- monsters
- raids
- reward_tables
- trophies
- restaurant_levels
- skill_tree_nodes
- localization

## 数据格式方向

首版建议使用 JSON 或 CSV + 导出 JSON。核心要求：

- 可由人类编辑。
- 可被脚本校验。
- 可被 Godot 稳定读取。
- 支持本地化文本键。

## 校验要求

- ID 唯一。
- 引用存在。
- 成本资源存在。
- 掉落表引用存在。
- 食谱引用的食材存在。
- 技能树前置节点存在。
- 魔物属性为正数。
- 战利品效果类型可识别。

## 关联文档

- [[design/02_content_systems/00_content_taxonomy|内容分类法]]
- [[design/06_technical_production/00_technical_requirements|技术需求]]

