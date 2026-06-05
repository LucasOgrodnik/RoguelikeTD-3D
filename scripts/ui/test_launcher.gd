extends Control

func _ready() -> void:
	$VBoxContainer/CombatBtn.pressed.connect(_on_combat_test)
	$VBoxContainer/WaveBtn.pressed.connect(_on_wave_test)
	$VBoxContainer/FullRunBtn.pressed.connect(_on_full_run_test)
	$VBoxContainer/MainGameBtn.pressed.connect(_on_main_game)
	$VBoxContainer/QuitBtn.pressed.connect(_on_quit)

func _on_combat_test() -> void:
	var test = CombatTest.new()
	get_tree().root.add_child(test)
	queue_free()

func _on_wave_test() -> void:
	var test = WaveProgressionTest.new()
	get_tree().root.add_child(test)
	queue_free()

func _on_full_run_test() -> void:
	var test = FullRunTest.new()
	get_tree().root.add_child(test)
	queue_free()

func _on_main_game() -> void:
	var game = GameLoopController.new()
	get_tree().root.add_child(game)
	queue_free()

func _on_quit() -> void:
	get_tree().quit()
