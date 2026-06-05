class_name ShopPanel
extends Control

var selected_heroes: Array[String] = []
var current_gold: int = 80
var placed_heroes: Array[String] = []

signal shop_complete(heroes_placed: Array[String])

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
	title.text = "BUY YOUR HEROES - Gold: %d" % current_gold
	title.add_theme_font_size_override("font_size", 24)
	vbox.add_child(title)

	var spacer = Control.new()
	spacer.custom_minimum_size = Vector2(0, 20)
	vbox.add_child(spacer)

	for hero in selected_heroes:
		var cost = EconomyManager.new().get_hero_cost(hero)
		var hbox = HBoxContainer.new()
		vbox.add_child(hbox)

		var label = Label.new()
		label.text = "%s - Cost: %d" % [hero.to_upper(), cost]
		hbox.add_child(label)

		var buy_btn = Button.new()
		buy_btn.text = "BUY"
		buy_btn.pressed.connect(_on_buy_hero.bindv([hero, cost]))
		hbox.add_child(buy_btn)

	var spacer2 = Control.new()
	spacer2.custom_minimum_size = Vector2(0, 20)
	vbox.add_child(spacer2)

	var proceed_btn = Button.new()
	proceed_btn.text = "PROCEED TO BATTLE"
	proceed_btn.custom_minimum_size = Vector2(200, 50)
	proceed_btn.pressed.connect(_on_proceed)
	vbox.add_child(proceed_btn)

func _on_buy_hero(hero: String, cost: int) -> void:
	if current_gold >= cost and hero not in placed_heroes:
		current_gold -= cost
		placed_heroes.append(hero)
		print("Bought %s! Remaining gold: %d" % [hero, current_gold])

func _on_proceed() -> void:
	shop_complete.emit(placed_heroes)
	queue_free()

func setup(heroes: Array[String], gold: int) -> void:
	selected_heroes = heroes
	current_gold = gold
