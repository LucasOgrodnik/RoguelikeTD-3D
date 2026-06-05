extends Node

const SAVE_PATH := "user://save_data.json"

static func load_data() -> Dictionary:
	if not FileAccess.file_exists(SAVE_PATH):
		return _default_data()
	var f := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if f == null:
		return _default_data()
	var text := f.get_as_text()
	f = null
	var parsed: Variant = JSON.parse_string(text)
	if not parsed is Dictionary:
		return _default_data()
	var data := _default_data()
	data.merge(parsed, true)
	return data

static func save_data(data: Dictionary) -> void:
	var f := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if f == null:
		push_error("SaveManager: impossible to open " + SAVE_PATH)
		return
	f.store_string(JSON.stringify(data, "\t"))
	f = null

static func _default_data() -> Dictionary:
	return {
		"total_runs": 0,
		"total_wins": 0,
		"best_score": 0,
		"gems": 0,
		"hero_upgrade_levels": {
			"bladedancer": {"damage": 0, "range": 0, "speed": 0},
			"pyromancer":  {"damage": 0, "range": 0, "speed": 0},
			"stormshard":  {"damage": 0, "range": 0, "speed": 0},
		},
		"hero_unlock_state": {
			"bladedancer": true,
			"pyromancer":  true,
			"stormshard":  true,
		},
		"challenge_progress": {
			"fire_damage_lifetime":      0,
			"slashing_damage_lifetime":  0,
			"electric_damage_lifetime":  0,
			"total_kills_lifetime":      0,
		},
		"last_roster": ["bladedancer", "pyromancer", "stormshard"],
	}

static func get_gems() -> int:
	return load_data().get("gems", 0)

static func add_gems(amount: int) -> void:
	var data := load_data()
	data["gems"] = data.get("gems", 0) + amount
	save_data(data)

static func spend_gems(amount: int) -> bool:
	var data := load_data()
	var current: int = data.get("gems", 0)
	if current < amount:
		return false
	data["gems"] = current - amount
	save_data(data)
	return true

static func get_hero_upgrade(hero_name: String, stat: String) -> int:
	var data := load_data()
	var levels: Dictionary = data.get("hero_upgrade_levels", {})
	var hero_levels: Dictionary = levels.get(hero_name.to_lower(), {})
	return hero_levels.get(stat, 0)

static func set_hero_upgrade(hero_name: String, stat: String, level: int) -> void:
	var data := load_data()
	var levels: Dictionary = data.get("hero_upgrade_levels", {})
	var hero_levels: Dictionary = levels.get(hero_name.to_lower(), {})
	hero_levels[stat] = level
	levels[hero_name.to_lower()] = hero_levels
	data["hero_upgrade_levels"] = levels
	save_data(data)

static func is_hero_unlocked(hero_name: String) -> bool:
	var data := load_data()
	var unlock_state: Dictionary = data.get("hero_unlock_state", {})
	return unlock_state.get(hero_name.to_lower(), false)

static func unlock_hero(hero_name: String) -> void:
	var data := load_data()
	var unlock_state: Dictionary = data.get("hero_unlock_state", {})
	unlock_state[hero_name.to_lower()] = true
	data["hero_unlock_state"] = unlock_state
	save_data(data)

static func get_last_roster() -> Array[String]:
	var data := load_data()
	return data.get("last_roster", ["bladedancer", "pyromancer", "stormshard"])

static func set_last_roster(roster: Array[String]) -> void:
	var data := load_data()
	data["last_roster"] = roster
	save_data(data)
