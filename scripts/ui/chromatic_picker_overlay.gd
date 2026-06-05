class_name ChromaticPickerOverlay
extends Control

var heroes = ["bladedancer", "pyromancer", "stormshard"]

signal hero_chosen(hero_name: String)

func _ready() -> void:
	anchor_top = 0.0
	anchor_left = 0.0
	anchor_right = 1.0
	anchor_bottom = 1.0
	offset_top = 0
	offset_left = 0
	offset_right = 0
	offset_bottom = 0

	modulate = Color.BLACK
	modulate.a = 0.9

	var vbox = VBoxContainer.new()
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	add_child(vbox)

	var title = Label.new()
	title.text = "Couronne Chromatique - Choose Hero to Boost"
	title.add_theme_font_size_override("font_size", 24)
	vbox.add_child(title)

	var spacer = Control.new()
	spacer.custom_minimum_size = Vector2(0, 20)
	vbox.add_child(spacer)

	for hero in heroes:
		var btn = Button.new()
		btn.text = hero.to_upper()
		btn.custom_minimum_size = Vector2(200, 50)
		btn.pressed.connect(_on_hero_chosen.bindv([hero]))
		vbox.add_child(btn)

func _on_hero_chosen(hero_name: String) -> void:
	hero_chosen.emit(hero_name)
	queue_free()
