class_name GameLoopController
extends Node3D

var game_state_machine: GameStateMachine
var run_controller: RunController
var terrain_manager: TerrainManager
var selected_heroes: Array[String] = []
var bought_heroes: Array[String] = []

signal game_started()
signal run_ended()

func _ready() -> void:
	game_state_machine = GameStateMachine.new()
	add_child(game_state_machine)

	run_controller = RunController.new()
	add_child(run_controller)

	terrain_manager = TerrainManager.new()
	add_child(terrain_manager)

	game_state_machine.change_state(GameStateMachine.State.MAIN_MENU)
	_start_game()

func _start_game() -> void:
	var trio_overlay = TrioSelectionOverlay.new()
	add_child(trio_overlay)
	trio_overlay.trio_selected.connect(_on_trio_selected)

func _on_trio_selected(heroes: Array[String]) -> void:
	selected_heroes = heroes
	print("Trio selected: %s" % [selected_heroes])
	game_state_machine.change_state(GameStateMachine.State.SHOP)
	_show_shop()

func _show_shop() -> void:
	var shop = ShopPanel.new()
	add_child(shop)
	shop.setup(selected_heroes, 80)
	shop.shop_complete.connect(_on_shop_complete)

func _on_shop_complete(heroes: Array[String]) -> void:
	bought_heroes = heroes
	print("Heroes purchased: %s" % [bought_heroes])
	game_state_machine.change_state(GameStateMachine.State.RUNNING)
	_start_run()

func _start_run() -> void:
	run_controller.start_run(selected_heroes)

	for hero_name in bought_heroes:
		var pos = terrain_manager.get_available_positions()[0]
		var hero = _create_hero(hero_name)
		hero.global_position = pos
		$GameWorld/Heroes.add_child(hero)

	game_state_machine.change_state(GameStateMachine.State.RUNNING)
	run_controller.start_wave(1)

func _create_hero(hero_name: String) -> Node3D:
	match hero_name.to_lower():
		"bladedancer":
			return Bladedancer.new()
		"pyromancer":
			return Pyromancer.new()
		"stormshard":
			return Stormshard.new()
		_:
			return Node3D.new()

func _process(_delta: float) -> void:
	if game_state_machine.current_state == GameStateMachine.State.RUNNING:
		_check_run_state()

func _check_run_state() -> void:
	var enemies_node = get_node_or_null("GameWorld/Enemies")
	if not enemies_node:
		return

	var alive_enemies = enemies_node.get_children().filter(
		func(e): return e.get_meta("is_alive", true)
	)

	if alive_enemies.is_empty():
		run_controller.end_wave()
