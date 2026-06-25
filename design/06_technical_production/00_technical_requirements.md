# 技术需求

状态：草案  
上级索引：[[design/README|Design Knowledge Base]]

## 目的

定义首版 MVP 和后续开发的技术边界、架构原则、工具需求和验证方式。

## 技术原则

- Godot 工程根目录固定为 `game/`。
- 玩法规则层与 Godot 表现层分离。
- 食材、菜品、勇者、魔物、奖励、战利品、技能树和本地化优先数据驱动。
- 自动战斗、资源结算和离线推进不应依赖场景节点树。
- 表现层读取规则层状态和事件日志，不自行结算经济或战斗。
- 每次新增数据结构时，同步补充校验规则。

## 首版 MVP 必须支持

- 金币、食材、菜品库存。
- 食材购买。
- 菜品制作。
- 勇者属性成长。
- 餐厅等级。
- 技能树基础节点。
- 魔物袭击倒计时。
- 派遣多名勇者。
- 简单攻防自动战斗。
- 讨伐奖励。
- 战利品被动。
- 本地存档。

## 规则层建议模块

- Economy：金币、食材、菜品库存。
- Cooking：食谱、制作成本、属性收益。
- Adventurer：勇者属性、成长、可出战状态。
- Raid：袭击倒计时、魔物威胁、派遣队伍。
- AutoBattle：战斗预测和结算。
- Reward：掉落表、战利品、奖励领取。
- Progression：餐厅等级、技能树。
- Save：持久化与离线推进。

## 验证要求

- 数据校验通过。
- 自动战斗公式可用单元测试验证。
- 资源消耗和奖励结算可重复测试。
- Godot 项目能启动到主界面。
- 存档读写和版本迁移有最小验证。

## 关联文档

- [[design/06_technical_production/01_data_pipeline_and_tools|数据管线与工具]]
- [[design/06_technical_production/02_save_config_platform|存档、配置与平台]]
- [[design/06_technical_production/03_simulation_and_offline_progress|模拟与离线推进]]

