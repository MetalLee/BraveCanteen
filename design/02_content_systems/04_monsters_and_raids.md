# 魔物与袭击

状态：草案  
上级索引：[[design/README|Design Knowledge Base]]

## 目的

定义魔物袭击内容、威胁等级、掉落和刷新规则。

## 袭击内容定位

魔物袭击是周期性目标和奖励来源。它应推动玩家思考当前勇者队伍是否足够强，以及下一步应该补哪类属性。

## 魔物类型方向

- 高攻魔物：考验队伍生命或防御。
- 高防魔物：考验队伍攻击。
- 高生命魔物：考验持续输出。
- 群体魔物：后续可考验出战人数或范围能力。
- 精英魔物：提供更好掉落。

## 数据字段建议

| 字段 | 说明 |
| --- | --- |
| id | 魔物 ID |
| name_key | 名称文本键 |
| threat_level | 威胁等级 |
| hp | 生命 |
| attack | 攻击 |
| defense | 防御 |
| raid_timer_seconds | 袭击倒计时 |
| reward_table_id | 奖励表 ID |
| tags | 魔物标签 |

## 设计准则

- 魔物属性应反向提示玩家需要准备什么。
- 袭击倒计时和奖励价值要匹配威胁等级。
- 首版不做过多特性，优先验证攻防公式和奖励闭环。

## 关联文档

- [[design/01_core_gameplay/05_raid_warning_and_dispatch|袭击预警与派遣]]
- [[design/02_content_systems/05_loot_and_trophies|掉落与战利品]]

