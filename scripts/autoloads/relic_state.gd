extends Node

var active_relics: Array[Dictionary] = []
var selected_roster: Array[String] = []
var legendary_acquired: bool = false
var chosen_chromatic_hero: String = ""
var global_dmg_mult: float = 1.0
var talisman_active: bool = false

func has_relic(relic_name: String) -> bool:
	for r: Dictionary in active_relics:
		if r.get("name", "") == relic_name:
			return true
	return false

func reset() -> void:
	active_relics.clear()
	legendary_acquired = false
	chosen_chromatic_hero = ""
	global_dmg_mult = 1.0
	talisman_active = false
