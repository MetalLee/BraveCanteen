# 术语表

状态：持续维护  
上级索引：[[design/README|Design Knowledge Base]]

## 目的

统一项目内高频术语，避免文档、数据表和代码实现使用不同命名。

## 核心术语

| 术语 | 定义 | 关联文档 |
| --- | --- | --- |
| 勇者餐厅 | 玩家经营的核心据点，负责购买食材、制作菜品、吸引勇者、升级设施和承接魔物威胁。 | [[design/01_core_gameplay/02_restaurant_operations|餐厅经营]] |
| 勇者 | 被餐厅吸引而来的冒险者，可通过菜品提升属性，并被派遣参与讨伐。 | [[design/01_core_gameplay/04_adventurer_growth|勇者成长]] |
| 菜品 | 由食材制作的成长载体，用于提升勇者属性或提供短期战斗增益。 | [[design/02_content_systems/02_recipes_and_dishes|食谱与菜品]] |
| 食材 | 菜品制作资源，可用金币购买，也可通过讨伐奖励获得。 | [[design/02_content_systems/01_ingredients|食材]] |
| 金币 | 基础货币，主要用于购买食材、推动餐厅升级和部分经营消耗。 | [[design/01_core_gameplay/07_resource_economy|资源与经济]] |
| 餐厅等级 | 餐厅长期成长层级，用于解锁高级食谱、吸引更强勇者和开放技能树节点。 | [[design/02_content_systems/06_restaurant_upgrades|餐厅升级]] |
| 技能树 | 餐厅长期强化系统，提供经营效率、勇者成长、战斗派遣和掉落收益等被动增益。 | [[design/02_content_systems/07_skill_tree|技能树]] |
| 魔物袭击 | 周期性刷新并倒计时预警的威胁事件，玩家需要选择勇者前往讨伐。 | [[design/01_core_gameplay/05_raid_warning_and_dispatch|袭击预警与派遣]] |
| 讨伐 | 勇者队伍与魔物进行自动战斗的过程。 | [[design/01_core_gameplay/06_auto_battle_system|自动战斗系统]] |
| 战利品 | 讨伐成功后获得的被动增益物，持续提升餐厅或勇者相关效果。 | [[design/02_content_systems/05_loot_and_trophies|掉落与战利品]] |
| 餐桌配餐 | Boss 战前最多选择 5 道菜形成一桌讨伐餐的准备玩法。 | [[design/01_core_gameplay/08_meal_table_combo_system|餐桌配餐与料理牌型系统]] |
| 餐桌槽位 | 一桌讨伐餐中的菜品位置，首版上限为 5 个。 | [[design/01_core_gameplay/08_meal_table_combo_system|餐桌配餐与料理牌型系统]] |
| 料理牌型 | 多道菜按同名、同主食材、同元素、同配料或职业职责形成的组合收益。 | [[design/01_core_gameplay/08_meal_table_combo_system|餐桌配餐与料理牌型系统]] |
| 小队核心 | Boss 战前指定的主要摄入和主要输出勇者，队友围绕其提供生存、克制、出血和侦察支援。 | [[design/01_core_gameplay/05_raid_warning_and_dispatch|袭击预警与派遣]] |
| 勇者喜好 | 勇者偏好的菜品或食材标签，匹配摄入会积累熟练度并带来封顶永久成长。 | [[design/01_core_gameplay/04_adventurer_growth|勇者成长]] |
| 厨具 | 一类偏烹饪构筑的战利品，用于强化特定料理牌型或改变配餐目标。 | [[design/02_content_systems/05_loot_and_trophies|掉落与战利品]] |

