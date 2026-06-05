class_name TrioSelectionOverlay
extends Control

var available_heroes = ["bladedancer", "pyromancer", "stormshard"]
var selected_heroes: Array[String] = []

signal trio_selected(heroes: Array[String])

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
	title.text = "SELECT YOUR TRIO"
	title.add_theme_font_size_override("font_size", 32)
	vbox.add_child(title)

	var spacer = Control.new()
	spacer.custom_minimum_size = Vector2(0, 20)
	vbox.add_child(spacer)

	for hero in available_heroes:
		var btn = Button.new()
		btn.text = hero.to_upper()
		btn.custom_minimum_size = Vector2(200, 50)
		btn.pressed.connect(_on_hero_selected.bindv([hero]))
		vbox.add_child(btn)

	var spacer2 = Control.new()
	spacer2.custom_minimum_size = Vector2(0, 20)
	vbox.add_child(spacer2)

	var start_btn = Button.new()
	start_btn.text = "START RUN"
	start_btn.custom_minimum_size = Vector2(200, 50)
	start_btn.pressed.connect(_on_start_pressed)
	vbox.add_child(start_btn)

func _on_hero_selected(hero: String) -> void:
	if hero not in selected_heroes:
		selected_heroes.append(hero)
		if selected_heroes.size() > 3:
			selected_heroes.pop_front()
	print("Selected: %s (Total: %d/3)" % [hero, selected_heroes.size()])

func _on_start_pressed() -> void:
	if selected_heroes.size() == 3:
		trio_selected.emit(selected_heroes)
		queue_free()
	else:
		print("Select exactly 3 heroes!")
