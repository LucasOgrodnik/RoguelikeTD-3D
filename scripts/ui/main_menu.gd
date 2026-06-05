class_name MainMenu
extends Control

func _ready() -> void:
	anchor_top = 0.0
	anchor_left = 0.0
	anchor_right = 1.0
	anchor_bottom = 1.0
	offset_top = 0
	offset_left = 0
	offset_right = 0
	offset_bottom = 0

	var vbox = VBoxContainer.new()
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	add_child(vbox)

	var title = Label.new()
	title.text = "ROGUELIKE TD - 3D"
	title.add_theme_font_size_override("font_size", 48)
	vbox.add_child(title)

	var spacer1 = Control.new()
	spacer1.custom_minimum_size = Vector2(0, 40)
	vbox.add_child(spacer1)

	var play_btn = Button.new()
	play_btn.text = "PLAY"
	play_btn.custom_minimum_size = Vector2(300, 60)
	play_btn.pressed.connect(_on_play)
	vbox.add_child(play_btn)

	var spacer2 = Control.new()
	spacer2.custom_minimum_size = Vector2(0, 20)
	vbox.add_child(spacer2)

	var quit_btn = Button.new()
	quit_btn.text = "QUIT"
	quit_btn.custom_minimum_size = Vector2(300, 60)
	quit_btn.pressed.connect(_on_quit)
	vbox.add_child(quit_btn)

func _on_play() -> void:
	print("Starting game...")
	get_tree().change_scene_to_file("res://scenes/main/hud.tscn")

func _on_quit() -> void:
	get_tree().quit()
