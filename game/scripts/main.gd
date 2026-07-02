extends Control

const Data = preload("res://data/game_data.gd")

var gold := 60
var restaurant_level := 1
var ingredients := {}
var dishes := {}
var heroes := {}
var unlocked_flags := {}
var trophies := {}
var selected_heroes := {}
var raids := []
var raid_index := 0
var raid_time_left := 0
var event_log := []

var root_box: VBoxContainer
var header_label: Label
var raid_label: Label
var tabs: TabContainer

func _ready() -> void:
	_initialize_state()
	_build_ui()
	_refresh()

func _process(delta: float) -> void:
	if raid_time_left > 0:
		raid_time_left = max(0, raid_time_left - delta)
		if int(raid_time_left) % 2 == 0:
			_refresh_header()

func _initialize_state() -> void:
	ingredients = {"wheat": 0, "mushroom": 0, "meat": 0, "herb": 0, "monster_bone": 0, "flame_pepper": 0}
	dishes = {}
	heroes = {}
	for hero_id in Data.adventurers().keys():
		var hero = Data.adventurers()[hero_id].duplicate(true)
		hero["resting"] = 0
		if hero["unlock_level"] <= restaurant_level:
			heroes[hero_id] = hero
	raids = Data.raids()
	raid_time_left = raids[raid_index]["timer"]
	_add_log("勇者餐厅开张了。先购买食材，做菜强化勇者。")

func _build_ui() -> void:
	root_box = VBoxContainer.new()
	root_box.set_anchors_preset(Control.PRESET_FULL_RECT)
	root_box.add_theme_constant_override("separation", 8)
	add_child(root_box)

	var header_panel = PanelContainer.new()
	root_box.add_child(header_panel)
	var header_box = VBoxContainer.new()
	header_panel.add_child(header_box)
	header_label = Label.new()
	header_label.add_theme_font_size_override("font_size", 20)
	header_box.add_child(header_label)
	raid_label = Label.new()
	raid_label.add_theme_font_size_override("font_size", 16)
	header_box.add_child(raid_label)

	tabs = TabContainer.new()
	tabs.size_flags_vertical = Control.SIZE_EXPAND_FILL
	root_box.add_child(tabs)

func _refresh() -> void:
	_refresh_header()
	for child in tabs.get_children():
		tabs.remove_child(child)
		child.queue_free()
	_add_tab("餐厅总览", _build_overview_tab())
	_add_tab("食材与烹饪", _build_cooking_tab())
	_add_tab("勇者", _build_heroes_tab())
	_add_tab("袭击与派遣", _build_raid_tab())
	_add_tab("日志", _build_log_tab())

func _refresh_header() -> void:
	if header_label == null:
		return
	header_label.text = "金币 %d    餐厅等级 %d    出战上限 %d" % [gold, restaurant_level, _party_limit()]
	var raid = _current_raid()
	raid_label.text = "当前袭击：%s  威胁 %d  剩余 %s  预测：%s" % [raid["name"], raid["threat"], _format_time(raid_time_left), _prediction_label(_battle_preview(_selected_party_ids()))]

func _add_tab(title: String, content: Control) -> void:
	content.name = title
	tabs.add_child(content)

func _build_overview_tab() -> Control:
	var box = _scroll_vbox()
	box.add_child(_title("下一步目标"))
	box.add_child(_label("- 做至少一道菜并喂给勇者。"))
	box.add_child(_label("- 在袭击倒计时结束前选择队伍。"))
	box.add_child(_label("- 胜利后用奖励升级餐厅或解锁新食谱。"))
	box.add_child(_title("库存概览"))
	box.add_child(_label(_inventory_text()))
	box.add_child(_title("战利品"))
	box.add_child(_label(_trophy_text()))
	var upgrade_button = Button.new()
	upgrade_button.text = "升级餐厅（120 金币，解锁香草、欧文、技能节点）"
	upgrade_button.disabled = gold < 120 or restaurant_level >= 2
	upgrade_button.pressed.connect(_upgrade_restaurant)
	box.add_child(upgrade_button)
	var time_button = Button.new()
	time_button.text = "推进 30 秒"
	time_button.pressed.connect(func(): _advance_time(30))
	box.add_child(time_button)
	var save_row = HBoxContainer.new()
	var save_button = Button.new()
	save_button.text = "保存"
	save_button.pressed.connect(_save_game)
	save_row.add_child(save_button)
	var load_button = Button.new()
	load_button.text = "读取"
	load_button.pressed.connect(_load_game)
	save_row.add_child(load_button)
	box.add_child(save_row)
	return box.get_parent()

func _build_cooking_tab() -> Control:
	var box = _scroll_vbox()
	box.add_child(_title("购买食材"))
	for ingredient_id in Data.ingredients().keys():
		var item = Data.ingredients()[ingredient_id]
		if not _ingredient_buyable(ingredient_id):
			continue
		var button = Button.new()
		button.text = "购买 %s（%d 金币） 当前：%d" % [item["name"], item["price"], ingredients.get(ingredient_id, 0)]
		button.disabled = gold < item["price"]
		button.pressed.connect(_buy_ingredient.bind(ingredient_id))
		box.add_child(button)

	box.add_child(_title("制作菜品"))
	for recipe_id in Data.recipes().keys():
		if not _recipe_unlocked(recipe_id):
			continue
		var recipe = Data.recipes()[recipe_id]
		var button = Button.new()
		button.text = "制作 %s  消耗：%s  效果：%s  库存：%d" % [recipe["name"], _cost_text(recipe["cost"]), _effect_text(recipe["effect"]), dishes.get(recipe_id, 0)]
		button.disabled = not _can_cook(recipe_id)
		button.pressed.connect(_cook.bind(recipe_id))
		box.add_child(button)
	return box.get_parent()

func _build_heroes_tab() -> Control:
	var box = _scroll_vbox()
	for hero_id in heroes.keys():
		var hero = heroes[hero_id]
		var panel = PanelContainer.new()
		var hero_box = VBoxContainer.new()
		panel.add_child(hero_box)
		hero_box.add_child(_title("%s  [%s]" % [hero["name"], hero["role"]]))
		hero_box.add_child(_label("生命 %d    攻击 %d    防御 %d" % [hero["hp"], hero["attack"], hero["defense"]]))
		var feed_row = HBoxContainer.new()
		hero_box.add_child(feed_row)
		for recipe_id in Data.recipes().keys():
			if not _recipe_unlocked(recipe_id):
				continue
			var recipe = Data.recipes()[recipe_id]
			var button = Button.new()
			button.text = "喂 %s (%d)" % [recipe["name"], dishes.get(recipe_id, 0)]
			button.disabled = dishes.get(recipe_id, 0) <= 0
			button.pressed.connect(_feed_hero.bind(hero_id, recipe_id))
			feed_row.add_child(button)
		box.add_child(panel)
	return box.get_parent()

func _build_raid_tab() -> Control:
	var box = _scroll_vbox()
	var raid = _current_raid()
	box.add_child(_title("%s  威胁 %d" % [raid["name"], raid["threat"]]))
	box.add_child(_label("生命 %d    攻击 %d    防御 %d    剩余 %s" % [raid["hp"], raid["attack"], raid["defense"], _format_time(raid_time_left)]))
	box.add_child(_label("设计考点：根据魔物属性选择补攻击、防御或生命。"))

	box.add_child(_title("选择队伍"))
	for hero_id in heroes.keys():
		var hero = heroes[hero_id]
		var check = CheckBox.new()
		check.text = "%s  生命 %d / 攻击 %d / 防御 %d" % [hero["name"], hero["hp"], hero["attack"], hero["defense"]]
		check.button_pressed = selected_heroes.get(hero_id, false)
		check.disabled = not check.button_pressed and _selected_party_ids().size() >= _party_limit()
		check.toggled.connect(_toggle_hero.bind(hero_id))
		box.add_child(check)

	var preview = _battle_preview(_selected_party_ids())
	box.add_child(_title("战斗预测：%s" % _prediction_label(preview)))
	box.add_child(_label(_preview_text(preview)))
	var dispatch = Button.new()
	dispatch.text = "开始讨伐"
	dispatch.disabled = _selected_party_ids().is_empty()
	dispatch.pressed.connect(_dispatch)
	box.add_child(dispatch)
	return box.get_parent()

func _build_log_tab() -> Control:
	var box = _scroll_vbox()
	for line in event_log:
		box.add_child(_label(line))
	return box.get_parent()

func _buy_ingredient(ingredient_id: String) -> void:
	var item = Data.ingredients()[ingredient_id]
	if gold < item["price"]:
		return
	gold -= item["price"]
	ingredients[ingredient_id] = ingredients.get(ingredient_id, 0) + 1
	_add_log("购买了 %s。" % item["name"])
	_refresh()

func _cook(recipe_id: String) -> void:
	if not _can_cook(recipe_id):
		return
	var recipe = Data.recipes()[recipe_id]
	for ingredient_id in recipe["cost"].keys():
		ingredients[ingredient_id] -= recipe["cost"][ingredient_id]
	dishes[recipe_id] = dishes.get(recipe_id, 0) + 1
	_add_log("制作了 %s。" % recipe["name"])
	_refresh()

func _feed_hero(hero_id: String, recipe_id: String) -> void:
	if dishes.get(recipe_id, 0) <= 0:
		return
	var recipe = Data.recipes()[recipe_id]
	var hero = heroes[hero_id]
	dishes[recipe_id] -= 1
	for stat in recipe["effect"].keys():
		var value = recipe["effect"][stat]
		value = _apply_food_trophy_bonus(stat, value, hero)
		hero[stat] += value
	_add_log("%s 吃下 %s，属性提升：%s。" % [hero["name"], recipe["name"], _effect_text(recipe["effect"])])
	_refresh()

func _toggle_hero(pressed: bool, hero_id: String) -> void:
	if pressed and _selected_party_ids().size() >= _party_limit():
		return
	selected_heroes[hero_id] = pressed
	_refresh()

func _dispatch() -> void:
	var party_ids = _selected_party_ids()
	if party_ids.is_empty():
		return
	var preview = _battle_preview(party_ids)
	var raid = _current_raid()
	if preview["success"]:
		_apply_rewards(raid["rewards"])
		_add_log("讨伐成功：%s。%s" % [raid["name"], _reward_text(raid["rewards"])])
		raid_index = (raid_index + 1) % raids.size()
	else:
		_add_log("讨伐失败：%s。没有获得奖励，请补强关键属性后再战。" % raid["name"])
	selected_heroes.clear()
	raid_time_left = _current_raid()["timer"]
	_refresh()

func _apply_rewards(rewards: Dictionary) -> void:
	var reward_gold = rewards.get("gold", 0)
	if trophies.has("shiny_tip_jar"):
		reward_gold = int(ceil(reward_gold * 1.1))
	gold += reward_gold
	for ingredient_id in rewards.get("ingredients", {}).keys():
		ingredients[ingredient_id] = ingredients.get(ingredient_id, 0) + rewards["ingredients"][ingredient_id]
	for flag in rewards.get("flags", []):
		unlocked_flags[flag] = true
	var trophy_id = rewards.get("trophy", "")
	if trophy_id != "" and not trophies.has(trophy_id):
		trophies[trophy_id] = true
	if not trophies.has("shiny_tip_jar") and raid_index == 0:
		trophies["shiny_tip_jar"] = true

func _upgrade_restaurant() -> void:
	if gold < 120 or restaurant_level >= 2:
		return
	gold -= 120
	restaurant_level = 2
	for hero_id in Data.adventurers().keys():
		if Data.adventurers()[hero_id]["unlock_level"] <= restaurant_level and not heroes.has(hero_id):
			var hero = Data.adventurers()[hero_id].duplicate(true)
			hero["resting"] = 0
			heroes[hero_id] = hero
	_add_log("餐厅升到 2 级，香草、战士欧文和进阶菜品开放。")
	_refresh()

func _advance_time(seconds: int) -> void:
	raid_time_left = max(0, raid_time_left - seconds)
	if raid_time_left <= 0:
		_add_log("袭击已经抵达。现在应立即派遣勇者。")
	_refresh()

func _save_game() -> void:
	var payload = {
		"gold": gold,
		"restaurant_level": restaurant_level,
		"ingredients": ingredients,
		"dishes": dishes,
		"heroes": heroes,
		"unlocked_flags": unlocked_flags,
		"trophies": trophies,
		"selected_heroes": selected_heroes,
		"raid_index": raid_index,
		"raid_time_left": raid_time_left,
		"event_log": event_log
	}
	var file = FileAccess.open("user://bravecanteen_save.json", FileAccess.WRITE)
	if file == null:
		_add_log("保存失败：无法写入存档。")
	else:
		file.store_string(JSON.stringify(payload, "\t"))
		_add_log("游戏已保存。")
	_refresh()

func _load_game() -> void:
	if not FileAccess.file_exists("user://bravecanteen_save.json"):
		_add_log("没有找到存档。")
		_refresh()
		return
	var file = FileAccess.open("user://bravecanteen_save.json", FileAccess.READ)
	if file == null:
		_add_log("读取失败：无法打开存档。")
		_refresh()
		return
	var parsed = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		_add_log("读取失败：存档格式无效。")
		_refresh()
		return
	gold = parsed.get("gold", gold)
	restaurant_level = parsed.get("restaurant_level", restaurant_level)
	ingredients = parsed.get("ingredients", ingredients)
	dishes = parsed.get("dishes", dishes)
	heroes = parsed.get("heroes", heroes)
	unlocked_flags = parsed.get("unlocked_flags", unlocked_flags)
	trophies = parsed.get("trophies", trophies)
	selected_heroes = parsed.get("selected_heroes", selected_heroes)
	raid_index = parsed.get("raid_index", raid_index)
	raid_time_left = parsed.get("raid_time_left", raid_time_left)
	event_log = parsed.get("event_log", event_log)
	_add_log("游戏已读取。")
	_refresh()

func _battle_preview(party_ids: Array) -> Dictionary:
	var raid = _current_raid()
	var team_hp := 0
	var team_attack := 0
	var team_defense := 0
	for hero_id in party_ids:
		var hero = heroes[hero_id]
		team_hp += hero["hp"]
		team_attack += hero["attack"]
		team_defense += hero["defense"]
	var team_damage = max(1, team_attack - raid["defense"])
	var monster_damage = max(1, raid["attack"] - team_defense)
	var rounds_to_monster = int(ceil(float(raid["hp"]) / float(team_damage)))
	var rounds_to_team = 999
	if team_hp > 0:
		rounds_to_team = int(ceil(float(team_hp) / float(monster_damage)))
	return {
		"team_hp": team_hp,
		"team_attack": team_attack,
		"team_defense": team_defense,
		"team_damage": team_damage,
		"monster_damage": monster_damage,
		"rounds_to_monster": rounds_to_monster,
		"rounds_to_team": rounds_to_team,
		"success": rounds_to_monster <= rounds_to_team and team_hp > 0
	}

func _prediction_label(preview: Dictionary) -> String:
	if preview["team_hp"] <= 0:
		return "请选择队伍"
	if preview["rounds_to_monster"] <= preview["rounds_to_team"] * 0.6:
		return "稳定胜利"
	if preview["rounds_to_monster"] <= preview["rounds_to_team"]:
		return "有风险"
	if preview["rounds_to_monster"] <= preview["rounds_to_team"] * 1.3:
		return "极危险"
	return "几乎无法取胜"

func _preview_text(preview: Dictionary) -> String:
	return "队伍：生命 %d / 攻击 %d / 防御 %d\n有效伤害：队伍 %d，魔物 %d\n击败回合：队伍击败魔物 %d 回合，魔物击败队伍 %d 回合" % [
		preview["team_hp"], preview["team_attack"], preview["team_defense"],
		preview["team_damage"], preview["monster_damage"],
		preview["rounds_to_monster"], preview["rounds_to_team"]
	]

func _current_raid() -> Dictionary:
	return raids[raid_index]

func _selected_party_ids() -> Array:
	var ids := []
	for hero_id in selected_heroes.keys():
		if selected_heroes[hero_id]:
			ids.append(hero_id)
	return ids

func _party_limit() -> int:
	return 3 if restaurant_level >= 2 else 2

func _ingredient_buyable(ingredient_id: String) -> bool:
	var item = Data.ingredients()[ingredient_id]
	if item["price"] < 0:
		return false
	if ingredient_id == "herb" and restaurant_level < 2:
		return false
	return true

func _recipe_unlocked(recipe_id: String) -> bool:
	var recipe = Data.recipes()[recipe_id]
	if restaurant_level < recipe["unlock_level"]:
		return false
	var flag = recipe["unlock_flag"]
	return flag == "" or unlocked_flags.has(flag)

func _can_cook(recipe_id: String) -> bool:
	var recipe = Data.recipes()[recipe_id]
	for ingredient_id in recipe["cost"].keys():
		if ingredients.get(ingredient_id, 0) < recipe["cost"][ingredient_id]:
			return false
	return true

func _apply_food_trophy_bonus(stat: String, value: int, hero: Dictionary) -> int:
	var result := value
	if stat == "defense" and trophies.has("bone_menu_board"):
		result = int(ceil(result * 1.1))
	if stat == "attack" and trophies.has("ember_spice_box"):
		result = int(ceil(result * 1.15))
	if stat == "attack" and trophies.has("wolf_tooth_token") and (hero["role"] == "游侠" or hero["role"] == "战士"):
		result = int(ceil(result * 1.1))
	return result

func _scroll_vbox() -> VBoxContainer:
	var scroll = ScrollContainer.new()
	scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	var box = VBoxContainer.new()
	box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	box.add_theme_constant_override("separation", 8)
	scroll.add_child(box)
	return box

func _title(text: String) -> Label:
	var label = Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", 18)
	return label

func _label(text: String) -> Label:
	var label = Label.new()
	label.text = text
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	return label

func _inventory_text() -> String:
	var lines := []
	for ingredient_id in ingredients.keys():
		lines.append("%s x%d" % [Data.ingredients()[ingredient_id]["name"], ingredients[ingredient_id]])
	for recipe_id in dishes.keys():
		if dishes[recipe_id] > 0:
			lines.append("%s x%d" % [Data.recipes()[recipe_id]["name"], dishes[recipe_id]])
	return "\n".join(lines) if not lines.is_empty() else "暂无库存"

func _trophy_text() -> String:
	if trophies.is_empty():
		return "暂无战利品"
	var lines := []
	for trophy_id in trophies.keys():
		var trophy = Data.trophies()[trophy_id]
		lines.append("%s：%s" % [trophy["name"], trophy["effect"]])
	return "\n".join(lines)

func _cost_text(cost: Dictionary) -> String:
	var parts := []
	for ingredient_id in cost.keys():
		parts.append("%s x%d" % [Data.ingredients()[ingredient_id]["name"], cost[ingredient_id]])
	return "，".join(parts)

func _effect_text(effect: Dictionary) -> String:
	var stat_names = {"hp": "生命", "attack": "攻击", "defense": "防御"}
	var parts := []
	for stat in effect.keys():
		parts.append("%s +%d" % [stat_names[stat], effect[stat]])
	return "，".join(parts)

func _reward_text(rewards: Dictionary) -> String:
	var parts := ["金币 +%d" % rewards.get("gold", 0)]
	for ingredient_id in rewards.get("ingredients", {}).keys():
		parts.append("%s +%d" % [Data.ingredients()[ingredient_id]["name"], rewards["ingredients"][ingredient_id]])
	for flag in rewards.get("flags", []):
		if flag == "bone_recipe":
			parts.append("解锁骨髓护甲汤")
		if flag == "flame_recipe":
			parts.append("解锁烈焰勇气饭")
	var trophy_id = rewards.get("trophy", "")
	if trophy_id != "":
		parts.append("可能获得战利品：%s" % Data.trophies()[trophy_id]["name"])
	return "奖励：" + "，".join(parts)

func _format_time(seconds: float) -> String:
	var total = int(ceil(seconds))
	return "%02d:%02d" % [int(total / 60), total % 60]

func _add_log(text: String) -> void:
	event_log.push_front(text)
	if event_log.size() > 30:
		event_log.pop_back()
