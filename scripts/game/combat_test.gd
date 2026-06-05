class_name CombatTest
extends Node3D

var hero: Node3D = null
var enemies: Array[Node3D] = []
var combat_manager: CombatManager = null
var test_passed: bool = false
var test_complete: bool = false

func _ready() -> void:
	combat_manager = CombatManager.new()
	add_child(combat_manager)

	_setup_test_combat()

	combat_manager.combat_event.connect(_on_combat_event)

func _setup_test_combat() -> void:
	var hero_pos = Vector3(0, 0, 0)
	var enemy_pos = Vector3(5, 0, 0)

	hero = Bladedancer.new()
	add_child(hero)
	hero.global_position = hero_pos
	combat_manager.register_hero(hero)

	var enemy = SkeletonWarrior.new()
	add_child(enemy)
	enemy.global_position = enemy_pos
	enemies.append(enemy)
	combat_manager.register_enemy(enemy)

	print("Combat Test Started: Bladedancer vs SkeletonWarrior")

func _process(_delta: float) -> void:
	if not test_complete and enemies.size() > 0:
		var alive_enemies = enemies.filter(func(e): return e.get_meta("is_alive", true))
		if alive_enemies.is_empty():
			_end_test()

func _on_combat_event(event_type: String, data: Dictionary) -> void:
	match event_type:
		"hero_attacked":
			print("Hero attacked! Damage: %.1f" % data["damage"])
		"enemy_died":
			print("Enemy died! Gold: %d" % data["gold"])

func _end_test() -> void:
	test_complete = true
	test_passed = true
	print("Combat Test Complete: PASSED ✓")
