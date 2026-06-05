class_name WaveEndScreen
extends Control

var wave_num: int = 0
var gold_earned: int = 0
var gold_total: int = 0

signal wave_continue()

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
	modulate.a = 0.7

	var vbox = VBoxContainer.new()
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	add_child(vbox)

	var title = Label.new()
	title.text = "WAVE %d COMPLETE" % wave_num
	title.add_theme_font_size_override("font_size", 40)
	vbox.add_child(title)

	var spacer1 = Control.new()
	spacer1.custom_minimum_size = Vector2(0, 20)
	vbox.add_child(spacer1)

	var gold_label = Label.new()
	gold_label.text = "Gold earned: +%d" % gold_earned
	gold_label.add_theme_font_size_override("font_size", 24)
	vbox.add_child(gold_label)

	var total_label = Label.new()
	total_label.text = "Total gold: %d" % gold_total
	total_label.add_theme_font_size_override("font_size", 20)
	vbox.add_child(total_label)

	var spacer2 = Control.new()
	spacer2.custom_minimum_size = Vector2(0, 30)
	vbox.add_child(spacer2)

	if wave_num % 5 == 0 and wave_num < 20:
		var event_label = Label.new()
		event_label.text = "(Next: Event Screen)"
		event_label.add_theme_font_size_override("font_size", 16)
		vbox.add_child(event_label)
	elif wave_num == 20:
		var victory_label = Label.new()
		victory_label.text = "VICTORY!"
		victory_label.add_theme_font_size_override("font_size", 32)
		vbox.add_child(victory_label)
	else:
		var draft_label = Label.new()
		draft_label.text = "(Next: Relic Draft)"
		draft_label.add_theme_font_size_override("font_size", 16)
		vbox.add_child(draft_label)

	var spacer3 = Control.new()
	spacer3.custom_minimum_size = Vector2(0, 30)
	vbox.add_child(spacer3)

	var continue_btn = Button.new()
	continue_btn.text = "CONTINUE"
	continue_btn.custom_minimum_size = Vector2(200, 50)
	continue_btn.pressed.connect(_on_continue)
	vbox.add_child(continue_btn)

func setup(wave: int, gold: int, total: int) -> void:
	wave_num = wave
	gold_earned = gold
	gold_total = total

func _on_continue() -> void:
	wave_continue.emit()
	queue_free()
