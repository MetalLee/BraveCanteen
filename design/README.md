# Design Knowledge Base

本目录是《BraveCanteen》的最高设计准则。后续 Godot 开发、数值调整、内容扩展、灵感整理、竞品洞察沉淀，均应优先遵循 `design/` 中已经确认的设计；`inspiration/` 和 `insight/` 只作为输入来源，不直接覆盖已确认规范。

## 使用规则

- 新灵感进入 `inspiration/` 后，先提炼核心观点，再链接到对应设计文档。
- 新竞品洞察进入 `insight/` 后，先评估来源可靠性，再沉淀为可借鉴点、可规避点或待验证假设。
- 对玩法、数值、内容、体验或制作范围有实质影响的修改，必须记录到 [[design/08_governance/00_decision_log|决策记录]]。
- 发生设计变更时，在相关文档中更新当前准则，并在 [[design/08_governance/01_change_log|变更日志]] 留下摘要。
- 尚未确认的信息使用“待验证”“假设”“草案”标记，避免把想法误当成规则。

## 文档地图

### 00 Product

定义产品方向、玩家承诺、设计支柱、目标玩家、范围边界和成功标准。

- [[design/00_product/00_game_concept|游戏概述]]
- [[design/00_product/01_design_pillars|设计支柱]]
- [[design/00_product/02_player_and_market|目标玩家与市场定位]]
- [[design/00_product/03_scope_and_success_criteria|项目范围与成功标准]]

### 01 Core Gameplay

定义经营、增量成长、勇者强化、魔物袭击和自动战斗之间的核心循环。

- [[design/01_core_gameplay/00_core_loop|核心循环]]
- [[design/01_core_gameplay/01_session_and_time_structure|会话与时间结构]]
- [[design/01_core_gameplay/02_restaurant_operations|餐厅经营]]
- [[design/01_core_gameplay/03_incremental_progression|增量成长]]
- [[design/01_core_gameplay/04_adventurer_growth|勇者成长]]
- [[design/01_core_gameplay/05_raid_warning_and_dispatch|袭击预警与派遣]]
- [[design/01_core_gameplay/06_auto_battle_system|自动战斗系统]]
- [[design/01_core_gameplay/07_resource_economy|资源与经济]]

### 02 Content Systems

定义食材、菜品、勇者、魔物、战利品、餐厅升级和技能树等可扩展内容框架。

- [[design/02_content_systems/00_content_taxonomy|内容分类法]]
- [[design/02_content_systems/01_ingredients|食材]]
- [[design/02_content_systems/02_recipes_and_dishes|食谱与菜品]]
- [[design/02_content_systems/03_adventurers|勇者]]
- [[design/02_content_systems/04_monsters_and_raids|魔物与袭击]]
- [[design/02_content_systems/05_loot_and_trophies|掉落与战利品]]
- [[design/02_content_systems/06_restaurant_upgrades|餐厅升级]]
- [[design/02_content_systems/07_skill_tree|技能树]]

### 03 Experience

定义玩家如何理解、操作、等待、收获和感受游戏。

- [[design/03_experience/00_ui_ux|界面与交互]]
- [[design/03_experience/01_visual_direction|视觉方向]]
- [[design/03_experience/02_audio_feedback|音频与反馈]]
- [[design/03_experience/03_onboarding_accessibility|引导与可访问性]]
- [[design/03_experience/04_feedback_and_game_feel|反馈与手感]]

### 04 Balance Data

定义经营经济、属性公式、战斗曲线、推进节奏和测试指标。

- [[design/04_balance_data/00_balance_principles|平衡原则]]
- [[design/04_balance_data/01_economy_curve|经济曲线]]
- [[design/04_balance_data/02_attribute_and_combat_formula|属性与战斗公式]]
- [[design/04_balance_data/03_progression_pacing|推进节奏]]
- [[design/04_balance_data/04_metrics_and_playtest_data|指标与测试数据]]

### 05 Narrative World

定义勇者餐厅、魔物威胁、叙事语气和文本投放边界。

- [[design/05_narrative_world/00_world_and_tone|世界观与语气]]
- [[design/05_narrative_world/01_restaurant_setting|餐厅设定]]
- [[design/05_narrative_world/02_adventurer_and_monster_flavor|勇者与魔物风味]]
- [[design/05_narrative_world/03_story_delivery|叙事投放]]

### 06 Technical Production

定义技术约束、数据管线、存档、平台、模拟推进和离线收益要求。

- [[design/06_technical_production/00_technical_requirements|技术需求]]
- [[design/06_technical_production/01_data_pipeline_and_tools|数据管线与工具]]
- [[design/06_technical_production/02_save_config_platform|存档、配置与平台]]
- [[design/06_technical_production/03_simulation_and_offline_progress|模拟与离线推进]]

### 07 Production

定义里程碑、范围控制、风险管理、测试节奏和 MVP 状态。

- [[design/07_production/00_roadmap_milestones|开发路线图与里程碑]]
- [[design/07_production/01_scope_risk_backlog|范围、风险与待办池]]
- [[design/07_production/02_playtest_plan|试玩测试计划]]
- [[design/07_production/03_mvp_project_status|MVP 项目状态]]

### 08 Governance

定义知识库、术语和设计决策如何被维护。

- [[design/08_governance/00_decision_log|决策记录]]
- [[design/08_governance/01_change_log|变更日志]]
- [[design/08_governance/02_glossary|术语表]]

## 模板

- [[design/_templates/design_doc_template|设计文档模板]]
- [[design/_templates/content_spec_template|内容规格模板]]
- [[design/_templates/decision_record_template|决策记录模板]]

