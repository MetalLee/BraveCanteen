# 属性与战斗公式

状态：草案  
上级索引：[[design/README|Design Knowledge Base]]

## 目的

定义勇者属性、魔物属性和自动战斗结算公式的首版规则。

## 首版属性

- 生命：总容错池，决定队伍能承受多少最终伤害。
- 攻击：造成伤害。
- 防御：减伤能力，主要降低每次受到的伤害。
- 精力：影响职业行动次数，主要通过青菜类菜品提升。

## 生命与防御区分

生命和防御都服务生存，但玩家感受必须不同：

| 属性 | 核心问题 | 更适合应对 | 玩家理解 |
| --- | --- | --- | --- |
| 生命 | “我能不能扛住最终总伤害？” | 高爆发、无法完全减免的重击、Boss 狂暴 | 血条更厚，容错更高。 |
| 防御 | “敌人每次打我疼不疼？” | 多段小攻击、持续普通攻击、高频袭击 | 每次少掉血，打持久战更稳。 |

设计上，生命适合对抗少数高伤害事件，防御适合对抗多次中低伤害。若两个属性在预测中给出相同结果，应优先调整魔物攻击模式或公式展示，避免玩家觉得它们是同一种东西。

## 首版结算公式

```text
team_hp = sum(adventurer.hp)
team_attack = sum(adventurer.attack)
team_defense = sum(adventurer.defense)
extra_actions = count(adventurer.energy >= 3)

team_damage_per_round = max(1, team_attack - monster.defense)
monster_damage_per_round = max(1, monster.attack - team_defense)

rounds_to_defeat_monster = ceil(monster.hp / team_damage_per_round)
rounds_to_defeat_team = ceil(team_hp / monster_damage_per_round)

success = rounds_to_defeat_monster <= rounds_to_defeat_team
```

首版仍可使用简单减法公式，但战斗预测应补充解释：

```text
if monster.attack_count_per_round > 1:
  defense_value_hint = "防御收益较高"

if monster.has_heavy_strike or monster.has_berserk:
  hp_value_hint = "生命收益较高"
```

后续若需要进一步拉开差异，可以把魔物攻击拆成 `attack_damage` 和 `attack_count_per_round`。防御对每次攻击生效，因此面对多段攻击更强；生命对所有伤害都有效，因此面对重击和机制伤害更稳。

精力额外行动首版不直接写成统一攻击倍率，而是按职业职责解释，并在战斗预测中折算为可读结果。

```text
if adventurer.energy >= 3:
  adventurer_extra_action = 1
else:
  adventurer_extra_action = 0
```

职业额外行动示例：

| 职业 | 额外行动折算 |
| --- | --- |
| 战士 | 追加一次普通攻击，降低 `rounds_to_defeat_monster`。 |
| 盾兵 | 追加一次格挡或承伤，提高 `rounds_to_defeat_team`。 |
| 法师 | 追加一次低倍率法术或提高属性克制爆发。 |
| 弓箭手 | 先破坏部位造成出血，再追射造成可观伤害并叠加出血。 |
| 游侠 | 提高 Boss 机制侦察完整度或额外压制轻机制。 |

## 出血公式

出血由弓箭手破坏 Boss 部位造成。Boss 每次攻击时，根据出血层数扣除自身最大生命百分比。

```text
bleed_damage_per_attack = boss.max_hp * bleed_stack * bleed_percent
```

首版建议：

| 参数 | 建议值 | 说明 |
| --- | --- | --- |
| `bleed_percent` | 0.01 | 每层出血每次 Boss 攻击造成 1% 最大生命伤害。 |
| `max_bleed_stack` | 3 | 首版最高 3 层，避免百分比伤害失控。 |
| `bleed_direct_shot_multiplier` | 1.5 | 弓箭手再次攻击已出血部位时的直接伤害倍率，可后续调参。 |

出血价值与 Boss 攻击次数强相关：

```text
bleed_damage_per_round = bleed_damage_per_attack * boss.attack_count_per_round
```

派遣预测需要显示“预计出血收益”，例如“Boss 每回合攻击 3 次，1 层出血每回合预计造成 3% 最大生命伤害”。

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
- 精力阈值必须在派遣前显示，例如“战士精力 3/3：将额外攻击 1 次”。
- 首版不建议让精力无限叠加行动次数，避免回合数和日志膨胀。
- 生命和防御的推荐提示必须分开显示，例如“建议补生命承受重击”或“建议补防御降低多段伤害”。
- 出血属于百分比伤害，必须显示层数、触发条件和预计收益，并设置层数上限。

## 关联文档

- [[design/01_core_gameplay/06_auto_battle_system|自动战斗系统]]
- [[design/02_content_systems/03_adventurers|勇者]]
- [[design/02_content_systems/04_monsters_and_raids|魔物与袭击]]

