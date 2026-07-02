extends RefCounted
class_name BraveCanteenData

static func ingredients() -> Dictionary:
	return {
		"wheat": {"name": "小麦", "rarity": "普通", "price": 5, "source": "金币购买", "use": "生命菜、通用菜"},
		"mushroom": {"name": "蘑菇", "rarity": "普通", "price": 7, "source": "金币购买", "use": "防御菜"},
		"meat": {"name": "肉块", "rarity": "普通", "price": 10, "source": "金币购买", "use": "攻击菜"},
		"herb": {"name": "香草", "rarity": "进阶", "price": 18, "source": "餐厅等级 2 解锁", "use": "复合属性菜"},
		"monster_bone": {"name": "魔物骨", "rarity": "稀有", "price": -1, "source": "讨伐掉落", "use": "防御高级菜、战利品"},
		"flame_pepper": {"name": "烈焰椒", "rarity": "稀有", "price": -1, "source": "高威胁讨伐掉落", "use": "高攻击菜"}
	}

static func recipes() -> Dictionary:
	return {
		"hero_soup": {
			"name": "勇者浓汤",
			"cost": {"wheat": 2},
			"effect": {"hp": 8},
			"unlock_level": 1,
			"unlock_flag": ""
		},
		"grilled_steak": {
			"name": "烤肉排",
			"cost": {"meat": 1},
			"effect": {"attack": 4},
			"unlock_level": 1,
			"unlock_flag": ""
		},
		"mushroom_shield_pot": {
			"name": "蘑菇盾锅",
			"cost": {"mushroom": 2, "wheat": 1},
			"effect": {"defense": 3},
			"unlock_level": 1,
			"unlock_flag": ""
		},
		"herb_stewed_meat": {
			"name": "香草炖肉",
			"cost": {"meat": 1, "herb": 1},
			"effect": {"attack": 3, "hp": 6},
			"unlock_level": 2,
			"unlock_flag": ""
		},
		"bone_armor_soup": {
			"name": "骨髓护甲汤",
			"cost": {"monster_bone": 1, "mushroom": 1},
			"effect": {"defense": 6},
			"unlock_level": 1,
			"unlock_flag": "bone_recipe"
		},
		"flame_courage_rice": {
			"name": "烈焰勇气饭",
			"cost": {"flame_pepper": 1, "meat": 1},
			"effect": {"attack": 9},
			"unlock_level": 1,
			"unlock_flag": "flame_recipe"
		}
	}

static func adventurers() -> Dictionary:
	return {
		"novice_lina": {"name": "见习勇者莉娜", "role": "见习勇者", "hp": 28, "attack": 6, "defense": 2, "unlock_level": 1},
		"guard_bram": {"name": "盾卫布拉姆", "role": "盾卫", "hp": 42, "attack": 4, "defense": 5, "unlock_level": 1},
		"ranger_mira": {"name": "游侠米拉", "role": "游侠", "hp": 24, "attack": 9, "defense": 1, "unlock_level": 1},
		"warrior_owen": {"name": "战士欧文", "role": "战士", "hp": 36, "attack": 7, "defense": 3, "unlock_level": 2}
	}

static func raids() -> Array:
	return [
		{"id": "slime_pack", "name": "史莱姆群", "threat": 1, "hp": 35, "attack": 5, "defense": 1, "timer": 180, "rewards": {"gold": 35, "ingredients": {"wheat": 2, "mushroom": 1}, "flags": [], "trophy": ""}},
		{"id": "hungry_wolf", "name": "饥饿狼", "threat": 2, "hp": 55, "attack": 9, "defense": 2, "timer": 240, "rewards": {"gold": 60, "ingredients": {"meat": 2}, "flags": [], "trophy": "wolf_tooth_token"}},
		{"id": "stone_boar", "name": "石皮野猪", "threat": 3, "hp": 75, "attack": 8, "defense": 5, "timer": 300, "rewards": {"gold": 85, "ingredients": {"monster_bone": 1}, "flags": ["bone_recipe"], "trophy": "bone_menu_board"}},
		{"id": "ember_imp", "name": "余烬小鬼", "threat": 4, "hp": 90, "attack": 13, "defense": 3, "timer": 360, "rewards": {"gold": 120, "ingredients": {"flame_pepper": 1, "meat": 1}, "flags": ["flame_recipe"], "trophy": "ember_spice_box"}}
	]

static func trophies() -> Dictionary:
	return {
		"shiny_tip_jar": {"name": "发光小费罐", "effect": "基础金币收入 +10%"},
		"bone_menu_board": {"name": "骨制菜单牌", "effect": "防御类菜品效果 +10%"},
		"wolf_tooth_token": {"name": "狼牙挂饰", "effect": "战士和游侠攻击成长 +10%"},
		"ember_spice_box": {"name": "余烬香料盒", "effect": "攻击类菜品效果 +15%"}
	}
