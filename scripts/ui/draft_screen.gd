class_name DraftScreen
extends Control

var available_relics: Array[Dictionary] = []
var selected_relic: Dictionary = {}

signal relic_selected(relic: Dictionary)

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
	title.text = "CHOOSE A RELIC"
	title.add_theme_font_size_override("font_size", 32)
	vbox.add_child(title)

	var spacer1 = Control.new()
	spacer1.custom_minimum_size = Vector2(0, 20)
	vbox.add_child(spacer1)

	var hbox = HBoxContainer.new()
	hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.add_child(hbox)

	for relic in available_relics:
		var btn = Button.new()
		btn.text = "%s\n(%s)" % [relic["name"], relic["rarity"]]
		btn.custom_minimum_size = Vector2(200, 100)
		btn.pressed.connect(_on_relic_selected.bindv([relic]))
		hbox.add_child(btn)

func setup(wave_num: int) -> void:
	available_relics.clear()

	for i in range(3):
		var relic = RelicDefinitions.get_random_relic(wave_num, RelicState.active_relics)
		available_relics.append(relic)

	print("Draft wave %d: %s" % [wave_num, available_relics.map(func(r): return r["name"])])

func _on_relic_selected(relic: Dictionary) -> void:
	selected_relic = relic
	RelicState.active_relics.append(relic)

	if relic["rarity"] == "legendary":
		RelicState.legendary_acquired = true

	if relic.has("multiplier"):
		RelicState.global_dmg_mult *= relic["multiplier"]

	if relic["id"] == "couronne_chromatique":
		_show_chromatic_picker()
	else:
		relic_selected.emit(relic)
		queue_free()

func _show_chromatic_picker() -> void:
	var picker = ChromaticPickerOverlay.new()
	add_child(picker)
	picker.hero_chosen.connect(_on_chromatic_hero_chosen)

func _on_chromatic_hero_chosen(hero_name: String) -> void:
	RelicState.chosen_chromatic_hero = hero_name
	relic_selected.emit(selected_relic)
	queue_free()
