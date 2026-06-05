class_name WaveSpawner
extends Node

var wave_manager: WaveManager
var current_wave: int = 0
var current_race: String = "skeleton"
var enemies_container: Node3D

signal wave_spawn_complete(wave_num: int, enemy_count: int)

func _ready() -> void:
	wave_manager = WaveManager.new()
	add_child(wave_manager)

func setup(race: String, enemies_node: Node3D) -> void:
	current_race = race
	enemies_container = enemies_node

func spawn_wave(wave_num: int) -> int:
	current_wave = wave_num

	var enemies = wave_manager.generate_wave(wave_num, current_race)

	for enemy in enemies:
		var spawn_pos = Vector3(randf_range(-5, 5), 0, randf_range(-2, 2))
		enemy.global_position = spawn_pos
		enemies_container.add_child(enemy)

	print("Wave %d spawned: %d enemies (Race: %s)" % [wave_num, enemies.size(), current_race])
	wave_spawn_complete.emit(wave_num, enemies.size())

	return enemies.size()

func get_wave_num() -> int:
	return current_wave
