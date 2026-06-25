# 内容分类法

状态：草案  
上级索引：[[design/README|Design Knowledge Base]]

## 目的

定义游戏内容的分类、命名和扩展边界，方便后续数据表、校验工具和 Obsidian 文档保持一致。

## 内容大类

| 大类 | 说明 | 关联文档 |
| --- | --- | --- |
| 食材 | 菜品制作的输入资源。 | [[design/02_content_systems/01_ingredients|食材]] |
| 食谱 / 菜品 | 勇者成长的主要载体。 | [[design/02_content_systems/02_recipes_and_dishes|食谱与菜品]] |
| 勇者 | 自动战斗的队伍单位。 | [[design/02_content_systems/03_adventurers|勇者]] |
| 魔物 / 袭击 | 周期性威胁和奖励来源。 | [[design/02_content_systems/04_monsters_and_raids|魔物与袭击]] |
| 掉落 / 战利品 | 讨伐奖励和长期被动。 | [[design/02_content_systems/05_loot_and_trophies|掉落与战利品]] |
| 餐厅升级 | 内容解锁与效率成长。 | [[design/02_content_systems/06_restaurant_upgrades|餐厅升级]] |
| 技能树 | 长期策略选择。 | [[design/02_content_systems/07_skill_tree|技能树]] |

## 命名规则

- 内容 ID 使用英文小写蛇形命名，如 `ingredient_wheat`、`recipe_hero_stew`。
- 展示名称通过本地化文本键引用，不直接写死在代码中。
- 同一内容大类内 ID 必须唯一。
- 数据中引用其他内容时必须使用稳定 ID。

## 标签建议

- 食材标签：`grain`、`meat`、`vegetable`、`rare`、`monster_drop`。
- 菜品标签：`attack`、`defense`、`hp`、`balanced`、`temporary_buff`。
- 勇者标签：`tank`、`damage`、`balanced`、`novice`、`elite`。
- 魔物标签：`beast`、`undead`、`armored`、`swarm`、`boss_like`。
- 战利品标签：`economy`、`cooking`、`combat`、`loot`、`offline`。

## 关联文档

- [[design/06_technical_production/01_data_pipeline_and_tools|数据管线与工具]]

