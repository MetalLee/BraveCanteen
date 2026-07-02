# BraveCanteen Godot Prototype

这是根据 [[../design/07_production/04_mvp_implementation_plan|MVP 实现方案]] 生成的 Godot 4.x 最小可玩原型。

## 打开方式

1. 用 Godot 4.x 打开本目录。
2. 确认工程文件为 `project.godot`。
3. 运行主场景 `res://scenes/Main.tscn`。

## 当前已实现

- 金币与食材库存。
- 食材购买。
- 菜品制作。
- 勇者喂食与属性成长。
- 餐厅等级 2 解锁。
- 魔物袭击倒计时。
- 多名勇者派遣。
- 自动战斗预测与结算。
- 讨伐奖励、食谱解锁和战利品被动。
- 本地保存与读取。

## 当前原型边界

- UI 以功能验证为主，尚未做正式美术和动效。
- 战斗为文本结算，没有战斗演出。
- 内容数据直接写在 `data/game_data.gd`，后续可迁移为 JSON 或 CSV。
- 当前环境未检测到 Godot 命令行，因此尚未在本机完成引擎启动校验。
