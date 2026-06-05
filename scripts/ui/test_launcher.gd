extends Control

func _ready() -> void:
	$VBoxContainer/CombatBtn.pressed.connect(_on_combat_test)
	$VBoxContainer/WaveBtn.pressed.connect(_on_wave_test)
	$VBoxContainer/FullRunBtn.pressed.connect(_on_full_run_test)
	$VBoxContainer/MainGameBtn.pressed.connect(_on_main_game)
	$VBoxContainer/QuitBtn.pressed.connect(_on_quit)

func _on_combat_test() -> void:
	print("Loading Combat Test...")
	get_tree().change_scene_to_file("res://scenes/main/simple_test.tscn")

func _on_wave_test() -> void:
	print("Loading Wave Test...")
	get_tree().change_scene_to_file("res://scenes/main/simple_test.tscn")

func _on_full_run_test() -> void:
	print("Loading Full Run Test...")
	get_tree().change_scene_to_file("res://scenes/main/simple_test.tscn")

func _on_main_game() -> void:
	print("Loading Main Game...")
	get_tree().change_scene_to_file("res://scenes/main/hud.tscn")

func _on_quit() -> void:
	get_tree().quit()
