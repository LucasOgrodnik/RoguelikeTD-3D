class_name RunController
extends Node3D

var game_state_machine: GameStateMachine
var wave_manager: WaveManager
var economy_manager: EconomyManager

var current_wave: int = 0
var current_race: String = ""
var player_base_hp: int = 100
var player_base_max_hp: int = 100
var gold: int = 80

var heroes_in_play: Array[Node3D] = []
var enemies_in_play: Array[Node3D] = []

signal wave_started(wave_number: int)
signal wave_ended(wave_number: int)
signal run_completed()
signal base_hp_changed(new_hp: int, max_hp: int)
signal gold_changed(new_gold: int)

func _ready() -> void:
	game_state_machine = GameStateMachine.new()
	add_child(game_state_machine)

	wave_manager = WaveManager.new()
	add_child(wave_manager)

	economy_manager = EconomyManager.new()
	add_child(economy_manager)

	RelicState.reset()

func start_run(selected_heroes: Array[String]) -> void:
	current_wave = 0
	current_race = ["skeleton", "orc"].pick_random()
	player_base_hp = player_base_max_hp
	gold = 80

	RelicState.selected_roster = selected_heroes

	game_state_machine.change_state(GameStateMachine.State.SHOP)

func start_wave(wave_num: int) -> void:
	current_wave = wave_num

	if current_wave > 20:
		end_run()
		return

	var enemies = wave_manager.generate_wave(wave_num, current_race)
	enemies_in_play = enemies

	game_state_machine.change_state(GameStateMachine.State.RUNNING)
	wave_started.emit(wave_num)

func end_wave() -> void:
	game_state_machine.change_state(GameStateMachine.State.WAVE_END)

	if current_wave % 5 == 0:
		game_state_machine.change_state(GameStateMachine.State.EVENT)
	else:
		game_state_machine.change_state(GameStateMachine.State.DRAFT)

	wave_ended.emit(current_wave)

func end_run() -> void:
	game_state_machine.change_state(GameStateMachine.State.GAME_OVER)

	var gems_earned = (current_wave * 5) + (50 if current_wave == 20 else 0)
	SaveManager.add_gems(gems_earned)

	run_completed.emit()

func take_base_damage(amount: int) -> void:
	player_base_hp = max(0, player_base_hp - amount)
	base_hp_changed.emit(player_base_hp, player_base_max_hp)

	if player_base_hp <= 0:
		end_run()

func add_gold(amount: int) -> void:
	gold += amount
	gold_changed.emit(gold)

func spend_gold(amount: int) -> bool:
	if gold < amount:
		return false
	gold -= amount
	gold_changed.emit(gold)
	return true

func place_hero(hero_name: String, position: Vector3) -> Node3D:
	var hero = Node3D.new()
	hero.name = hero_name
	hero.global_position = position
	$GameWorld/Heroes.add_child(hero)
	heroes_in_play.append(hero)
	return hero

func register_enemy_kill(gold_reward: int) -> void:
	add_gold(gold_reward)
