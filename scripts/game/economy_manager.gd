class_name EconomyManager
extends Node

var hero_costs = {
	"bladedancer": 50,
	"pyromancer": 65,
	"stormshard": 55,
}

var enemy_gold_rewards = {
	"skeleton_warrior": 10,
	"skeleton_rogue": 8,
	"skeleton_knight": 25,
	"skeleton_bonelord": 80,
	"orc_warrior": 12,
	"worg": 10,
	"orc_berserker": 30,
	"orc_warchief": 90,
}

func get_hero_cost(hero_name: String) -> int:
	return hero_costs.get(hero_name.to_lower(), 0)

func get_gold_reward(enemy_type: String) -> int:
	return enemy_gold_rewards.get(enemy_type, 5)

func get_wave_bonus(wave_num: int) -> int:
	return 10 + (wave_num * 2)

func can_purchase_hero(hero_name: String, current_gold: int) -> bool:
	var cost = get_hero_cost(hero_name)
	return current_gold >= cost

func purchase_hero(hero_name: String, current_gold: int) -> int:
	var cost = get_hero_cost(hero_name)
	if current_gold >= cost:
		return current_gold - cost
	return current_gold
