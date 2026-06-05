class_name EventScreen
extends Control

var wave_num: int = 0

signal event_complete(choice: String)

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
	modulate.a = 0.8

	var vbox = VBoxContainer.new()
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	add_child(vbox)

	var title = Label.new()
	title.text = "BOSS DEFEATED - Choose Reward"
	title.add_theme_font_size_override("font_size", 28)
	vbox.add_child(title)

	var spacer = Control.new()
	spacer.custom_minimum_size = Vector2(0, 30)
	vbox.add_child(spacer)

	var choices = [
		{"text": "Gold +50", "choice": "gold"},
		{"text": "Heal +30", "choice": "heal"},
		{"text": "Relic Draft", "choice": "relic"},
	]

	for choice in choices:
		var btn = Button.new()
		btn.text = choice["text"]
		btn.custom_minimum_size = Vector2(200, 50)
		btn.pressed.connect(_on_choice.bindv([choice["choice"]]))
		vbox.add_child(btn)

func setup(wave: int) -> void:
	wave_num = wave

func _on_choice(choice: String) -> void:
	event_complete.emit(choice)
	queue_free()
