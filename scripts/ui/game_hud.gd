class_name GameHUD
extends CanvasLayer

var wave_num: int = 0
var gold: int = 80
var base_hp: int = 100
var base_max_hp: int = 100
var current_race: String = "skeleton"

var wave_label: Label
var gold_label: Label
var hp_label: Label
var race_label: Label

func _ready() -> void:
	var vbox = VBoxContainer.new()
	add_child(vbox)

	wave_label = Label.new()
	wave_label.text = "Wave: 0/20"
	wave_label.add_theme_font_size_override("font_size", 20)
	vbox.add_child(wave_label)

	gold_label = Label.new()
	gold_label.text = "Gold: 80"
	gold_label.add_theme_font_size_override("font_size", 20)
	vbox.add_child(gold_label)

	hp_label = Label.new()
	hp_label.text = "Base HP: 100/100"
	hp_label.add_theme_font_size_override("font_size", 20)
	vbox.add_child(hp_label)

	race_label = Label.new()
	race_label.text = "Race: Skeleton"
	race_label.add_theme_font_size_override("font_size", 20)
	vbox.add_child(race_label)

func update_wave(wave: int) -> void:
	wave_num = wave
	wave_label.text = "Wave: %d/20" % wave

func update_gold(amount: int) -> void:
	gold = amount
	gold_label.text = "Gold: %d" % gold

func update_base_hp(hp: int, max_hp: int) -> void:
	base_hp = hp
	base_max_hp = max_hp
	hp_label.text = "Base HP: %d/%d" % [hp, max_hp]

func update_race(race: String) -> void:
	current_race = race
	race_label.text = "Race: %s" % race.to_upper()
