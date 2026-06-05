class_name CombatManager
extends Node

var heroes: Array[Node3D] = []
var enemies: Array[Node3D] = []

signal combat_event(event_type: String, data: Dictionary)

func _ready() -> void:
	pass

func register_hero(hero: Node3D) -> void:
	if hero not in heroes:
		heroes.append(hero)
		if hero.has_signal("attacked"):
			hero.attacked.connect(_on_hero_attacked)
		if hero.has_signal("died"):
			hero.died.connect(_on_hero_died)

func register_enemy(enemy: Node3D) -> void:
	if enemy not in enemies:
		enemies.append(enemy)
		if enemy.has_signal("died"):
			enemy.died.connect(_on_enemy_died)
		if enemy.has_signal("health_changed"):
			enemy.health_changed.connect(_on_enemy_health_changed)

func unregister_hero(hero: Node3D) -> void:
	heroes.erase(hero)

func unregister_enemy(enemy: Node3D) -> void:
	enemies.erase(enemy)

func _on_hero_attacked(target: Node3D, damage_dealt: float) -> void:
	combat_event.emit("hero_attacked", {
		"target": target,
		"damage": damage_dealt
	})

func _on_hero_died(hero_name: String) -> void:
	combat_event.emit("hero_died", {"hero_name": hero_name})

func _on_enemy_died(enemy_type: String, gold: int) -> void:
	combat_event.emit("enemy_died", {
		"enemy_type": enemy_type,
		"gold": gold
	})

func _on_enemy_health_changed(new_health: float, max_health: float) -> void:
	pass
