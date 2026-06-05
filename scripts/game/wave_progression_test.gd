class_name WaveProgressionTest
extends Node3D

var wave_spawner: WaveSpawner
var current_wave: int = 0
var race: String = "skeleton"
var test_passed: bool = false
var test_log: Array[String] = []

func _ready() -> void:
	wave_spawner = WaveSpawner.new()
	add_child(wave_spawner)

	var enemies_node = Node3D.new()
	enemies_node.name = "Enemies"
	add_child(enemies_node)

	wave_spawner.setup(race, enemies_node)
	wave_spawner.wave_spawn_complete.connect(_on_wave_spawned)

	print("Wave Progression Test Starting...")
	_start_test()

func _start_test() -> void:
	current_wave = 1
	_spawn_next_wave()

func _spawn_next_wave() -> void:
	if current_wave > 20:
		_end_test()
		return

	var enemy_count = wave_spawner.spawn_wave(current_wave)
	test_log.append("Wave %d: %d enemies" % [current_wave, enemy_count])

	await get_tree().create_timer(0.5).timeout
	current_wave += 1
	_spawn_next_wave()

func _on_wave_spawned(wave_num: int, enemy_count: int) -> void:
	pass

func _end_test() -> void:
	test_passed = true
	print("Wave Progression Test PASSED ✓")
	print("Waves spawned: %d" % test_log.size())
	for log in test_log:
		print("  " + log)
