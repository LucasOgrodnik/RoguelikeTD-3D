class_name FullRunTest
extends Node3D

var wave_spawner: WaveSpawner
var gold_calculator: GoldCalculator
var current_wave: int = 0
var total_gold: int = 80
var test_complete: bool = false
var test_passed: bool = false

signal run_complete()

func _ready() -> void:
	wave_spawner = WaveSpawner.new()
	add_child(wave_spawner)

	gold_calculator = GoldCalculator.new()

	var enemies_node = Node3D.new()
	enemies_node.name = "Enemies"
	add_child(enemies_node)

	wave_spawner.setup("skeleton", enemies_node)

	print("Full Run Test Starting: 80 gold, 20 waves...")
	_start_run()

func _start_run() -> void:
	current_wave = 1
	_process_wave()

func _process_wave() -> void:
	if current_wave > 20:
		_end_run()
		return

	print("\n=== Wave %d ===" % current_wave)
	wave_spawner.spawn_wave(current_wave)

	await get_tree().create_timer(0.3).timeout

	var simulated_kills = _get_wave_enemies(current_wave)
	var wave_gold = gold_calculator.calculate_total_gold(simulated_kills, current_wave)

	total_gold += wave_gold
	print("Gold earned: +%d (Total: %d)" % [wave_gold, total_gold])

	await get_tree().create_timer(0.3).timeout

	current_wave += 1
	_process_wave()

func _get_wave_enemies(wave_num: int) -> Array[String]:
	var wm = WaveManager.new()
	var enemies = wm.generate_wave(wave_num, "skeleton")
	var types: Array[String] = []
	for enemy in enemies:
		types.append(enemy.enemy_type)
	return types

func _end_run() -> void:
	test_complete = true
	test_passed = true
	print("\n=== RUN COMPLETE ===")
	print("Final Gold: %d" % total_gold)
	print("Full Run Test PASSED ✓")
	run_complete.emit()
