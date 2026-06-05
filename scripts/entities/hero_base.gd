class_name HeroBase
extends Node3D

var hero_name: String = ""
var damage: float = 10.0
var attack_speed: float = 1.0
var attack_range: float = 100.0
var crit_chance: float = 0.0
var max_health: float = 100.0
var health: float = 100.0

var current_target: Node3D = null
var attack_cooldown: float = 0.0
var is_alive: bool = true

signal health_changed(new_health: float, max_health: float)
signal died(hero_name: String)
signal attacked(target: Node3D, damage_dealt: float)
signal ultimate_triggered(source_hero_name: String)

func _ready() -> void:
	health = max_health
	_load_mesh()

func _physics_process(delta: float) -> void:
	if not is_alive:
		return

	attack_cooldown -= delta
	if attack_cooldown <= 0.0:
		_try_attack()

func _try_attack() -> void:
	var enemies_node = get_node_or_null("../../GameWorld/Enemies")
	if not enemies_node:
		return

	current_target = _find_nearest_enemy(enemies_node)
	if current_target:
		_perform_attack(current_target)

func _find_nearest_enemy(enemies_node: Node) -> Node3D:
	var nearest: Node3D = null
	var min_distance = attack_range

	for enemy in enemies_node.get_children():
		if not enemy is Node3D:
			continue
		var distance = global_position.distance_to(enemy.global_position)
		if distance < min_distance and enemy.get_meta("is_alive", true):
			nearest = enemy
			min_distance = distance

	return nearest

func _perform_attack(target: Node3D) -> void:
	var dmg = _roll_dmg()
	var damage_type = DamageTypes.Type.TRANCHANT

	if target.has_method("take_damage"):
		target.take_damage(dmg, damage_type, hero_name)

	attack_cooldown = 1.0 / attack_speed
	attacked.emit(target, dmg)

func _roll_dmg() -> float:
	if randf() < crit_chance:
		return damage * 1.5
	return damage

func take_damage(amount: float, dmg_type: int, attacker_id: String) -> void:
	health = max(0.0, health - amount)
	health_changed.emit(health, max_health)

	if health <= 0.0:
		_die()

func _die() -> void:
	is_alive = false
	died.emit(hero_name)
	queue_free()

func trigger_ultimate() -> void:
	ultimate_triggered.emit(hero_name)

func _load_mesh() -> void:
	var model_path = "res://assets/3d_models/%s.glb" % hero_name.to_lower()
	var mesh_instance: Node3D

	if ResourceLoader.exists(model_path):
		var model = load(model_path)
		mesh_instance = model.instantiate()
	else:
		mesh_instance = PlaceholderFactory.create_hero_placeholder(hero_name)

	add_child(mesh_instance)
