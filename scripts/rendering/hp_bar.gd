class_name HpBar
extends Node

var entity: Node3D = null
var current_health: float = 100.0
var max_health: float = 100.0

func setup(entity_ref: Node3D, initial_health: float, max_hp: float) -> void:
	entity = entity_ref
	current_health = initial_health
	max_health = max_hp

	if entity.has_signal("health_changed"):
		entity.health_changed.connect(_on_health_changed)

func _on_health_changed(new_health: float, new_max: float) -> void:
	current_health = new_health
	max_health = new_max
	var health_percent = clamp(current_health / max_health, 0.0, 1.0)
	print("%s Health: %.1f / %.1f (%.0f%%)" % [entity.name, current_health, max_health, health_percent * 100])
