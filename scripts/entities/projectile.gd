class_name Projectile
extends Node3D

var damage: float = 10.0
var damage_type: int = 0
var speed: float = 20.0
var target: Node3D = null
var attacker_id: String = ""
var lifetime: float = 5.0
var elapsed: float = 0.0
var start_pos: Vector3 = Vector3.ZERO
var aoe_radius: float = 0.0

func _ready() -> void:
	start_pos = global_position
	var mesh_instance = PlaceholderFactory.create_projectile_placeholder()
	add_child(mesh_instance)

func _physics_process(delta: float) -> void:
	elapsed += delta

	if not target or not is_instance_valid(target):
		queue_free()
		return

	var direction = (target.global_position - global_position).normalized()
	global_position += direction * speed * delta

	var distance = global_position.distance_to(target.global_position)
	if distance < 0.5:
		_hit_target()

	if elapsed >= lifetime:
		queue_free()

func _hit_target() -> void:
	if target.has_method("take_damage"):
		target.take_damage(damage, damage_type, attacker_id)

	if aoe_radius > 0:
		_apply_aoe()

	_create_impact_effect()
	queue_free()

func _apply_aoe() -> void:
	var enemies_node = get_node_or_null("../../GameWorld/Enemies")
	if not enemies_node:
		return

	for enemy in enemies_node.get_children():
		if enemy is Node3D and enemy != target:
			var dist = global_position.distance_to(enemy.global_position)
			if dist <= aoe_radius and enemy.has_method("take_damage"):
				enemy.take_damage(damage * 0.5, damage_type, attacker_id)

func _create_impact_effect() -> void:
	var effect = DamageNumber.new()
	effect.damage_amount = damage
	effect.global_position = global_position
	get_parent().add_child(effect)
	effect.set_damage(damage)
