# 属性与战斗公式

状态：草案  
上级索引：[[design/README|Design Knowledge Base]]

## 目的

定义勇者属性、魔物属性和自动战斗结算公式的首版规则。

## 首版属性

- 生命：承受伤害。
- 攻击：造成伤害。
- 防御：降低对方攻击有效值。

## 首版结算公式

```text
team_hp = sum(adventurer.hp)
team_attack = sum(adventurer.attack)
team_defense = sum(adventurer.defense)

team_damage_per_round = max(1, team_attack - monster.defense)
monster_damage_per_round = max(1, monster.attack - team_defense)

rounds_to_defeat_monster = ceil(monster.hp / team_damage_per_round)
rounds_to_defeat_team = ceil(team_hp / monster_damage_per_round)

success = rounds_to_defeat_monster <= rounds_to_defeat_team
```

## 预测标签

| 条件 | 标签 |
| --- | --- |
| `rounds_to_defeat_monster <= rounds_to_defeat_team * 0.6` | 稳定胜利 |
| `rounds_to_defeat_monster <= rounds_to_defeat_team` | 有风险 |
| `rounds_to_defeat_monster <= rounds_to_defeat_team * 1.3` | 极危险 |
| 其他 | 几乎无法取胜 |

## 设计准则

- 首版公式优先可读，不追求复杂模拟。
- 最小有效伤害为 1，避免完全破防失败导致黑箱。
- 后续随机性必须可解释，并在预测中体现。

## 关联文档

- [[design/01_core_gameplay/06_auto_battle_system|自动战斗系统]]
- [[design/02_content_systems/03_adventurers|勇者]]
- [[design/02_content_systems/04_monsters_and_raids|魔物与袭击]]

