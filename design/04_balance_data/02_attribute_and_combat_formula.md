# 属性与战斗公式

状态：草案  
上级索引：[[design/README|Design Knowledge Base]]

## 目的

定义勇者属性、魔物属性和自动战斗结算公式的首版规则。

## 首版属性

- 生命：承受伤害。
- 攻击：造成伤害。
- 防御：降低对方攻击有效值。
- 魔法攻击：绕开部分防御压力，用于应对魔法弱点魔物。
- 技能强度：提高职业自动技能效果，如守护、法术爆发、治疗或护盾。

## 伤害与弱点标签

首版使用少量标签连接职业、菜品和魔物弱点：

- `physical`：主要来自战士和普通攻击。
- `magic`：主要来自法师和奥术菜强化。
- `holy`：主要来自牧师技能和圣光菜强化。

弱点不引入随机判定。命中弱点时使用固定倍率，首版建议为 `1.5`。

## 首版结算公式

```text
team_hp = sum(adventurer.hp)
team_attack = sum(adventurer.attack)
team_defense = sum(adventurer.defense)
team_magic_attack = sum(adventurer.magic_attack)

warrior_guard_value = sum(warrior.skill_power) * guard_ratio
mage_spell_value = sum(mage.skill_power) * spell_ratio
priest_support_value = sum(priest.skill_power) * support_ratio
priest_holy_value = sum(priest.skill_power) * holy_ratio

effective_team_hp = team_hp + priest_support_value
effective_team_defense = team_defense + warrior_guard_value

physical_damage = max(1, team_attack - monster.defense)
magic_damage = team_magic_attack + mage_spell_value
holy_damage = priest_holy_value

if monster has weak_physical:
  physical_damage *= weakness_multiplier
if monster has weak_magic:
  magic_damage *= weakness_multiplier
if monster has weak_holy:
  holy_damage *= weakness_multiplier

team_damage_per_round = max(1, physical_damage + magic_damage + holy_damage)
monster_damage_per_round = max(1, monster.attack - effective_team_defense)

rounds_to_defeat_monster = ceil(monster.hp / team_damage_per_round)
rounds_to_defeat_team = ceil(effective_team_hp / monster_damage_per_round)

success = rounds_to_defeat_monster <= rounds_to_defeat_team
```

首版可先取简单系数：

| 参数 | 建议初值 | 说明 |
| --- | --- | --- |
| `weakness_multiplier` | `1.5` | 命中弱点的固定倍率 |
| `guard_ratio` | `0.5` | 战士技能强度转有效防御 |
| `spell_ratio` | `1.0` | 法师技能强度转额外魔法伤害 |
| `support_ratio` | `2.0` | 牧师技能强度转有效生命 |
| `holy_ratio` | `0.5` | 牧师技能强度转圣光伤害 |

这些系数必须放入可调配置，不写死在场景逻辑中。

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
- 弱点命中和职业技能贡献必须进入预测和战斗日志。
- 首版不做暴击、闪避、命中率和随机技能释放。
- 后续随机性必须可解释，并在预测中体现。

## 关联文档

- [[design/01_core_gameplay/06_auto_battle_system|自动战斗系统]]
- [[design/02_content_systems/03_adventurers|勇者]]
- [[design/02_content_systems/04_monsters_and_raids|魔物与袭击]]
