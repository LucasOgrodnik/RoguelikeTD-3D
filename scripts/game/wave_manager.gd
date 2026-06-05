class_name WaveManager
extends Node

var race_data = {
	"skeleton": {
		"enemies": ["skeleton_warrior", "skeleton_rogue", "skeleton_knight", "skeleton_bonelord"],
		"costs": {"skeleton_warrior": 5, "skeleton_rogue": 7, "skeleton_knight": 18, "skeleton_bonelord": 40}
	},
	"orc": {
		"enemies": ["orc_warrior", "worg", "orc_berserker", "orc_warchief"],
		"costs": {"orc_warrior": 8, "worg": 7, "orc_berserker": 28, "orc_warchief": 50}
	}
}

func generate_wave(wave_num: int, race: String) -> Array[Node3D]:
	var budget = int(floor(40.0 * pow(1.15, wave_num - 1)))
	var hp_multiplier = pow(1.05, wave_num - 1)

	var enemies: Array[Node3D] = []
	var race_info = race_data.get(race, race_data["skeleton"])
	var costs = race_info["costs"]

	var enemy_list = race_info["enemies"].duplicate()
	enemy_list.sort_custom(func(a, b): return costs[a] > costs[b])

	var spent = 0
	while spent < budget and enemies.size() < 30:
		for enemy_type in enemy_list:
			var cost = costs[enemy_type]
			if spent + cost <= budget and enemies.size() < 30:
				var enemy = _create_enemy_placeholder(enemy_type, hp_multiplier)
				enemies.append(enemy)
				spent += cost

	enemies.shuffle()
	return enemies

func _create_enemy_placeholder(enemy_type: String, hp_mult: float) -> Node3D:
	var enemy = PlaceholderFactory.create_enemy_placeholder(enemy_type)
	enemy.name = enemy_type
	enemy.set_meta("type", enemy_type)
	enemy.set_meta("hp_multiplier", hp_mult)
	return enemy
