# 勇者

状态：草案  
上级索引：[[design/README|Design Knowledge Base]]

## 目的

定义勇者内容的职业、属性、档位和扩展规则。

## 勇者内容定位

勇者是餐厅吸引来的战斗单位。玩家通过菜品强化他们，再选择他们参与讨伐。

## 首版职业方向

- 战士：攻击和生命均衡。
- 盾卫：生命和防御高。
- 游侠：攻击高，防御低。
- 见习勇者：低成本、前期教学单位。

## 数据字段建议

| 字段 | 说明 |
| --- | --- |
| id | 勇者 ID |
| name_key | 名称文本键 |
| rarity | 档位 |
| role | 职业定位 |
| base_hp | 基础生命 |
| base_attack | 基础攻击 |
| base_defense | 基础防御 |
| food_affinity_tags | 偏好菜品标签 |
| unlock_level | 所需餐厅等级 |

## 设计准则

- 勇者之间要有属性差异，避免只选总战力最高。
- 高阶勇者可以有更高成长倍率，但首版不做复杂技能。
- 勇者数量前期应少而清晰。

## 关联文档

- [[design/01_core_gameplay/04_adventurer_growth|勇者成长]]
- [[design/01_core_gameplay/06_auto_battle_system|自动战斗系统]]

