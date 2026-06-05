class_name EnemyBase
extends Node3D

var enemy_type: String = ""
var max_health: float = 60.0
var health: float = 60.0
var armor: float = 0.0
var speed: float = 3.0
var gold_reward: int = 10
var is_alive: bool = true

var weaknesses: Array[int] = []
var resistances: Array[int] = []

var current_waypoint_idx: int = 0
var waypoints: Array[Vector3] = []

signal health_changed(new_health: float, max_health: float)
signal died(enemy_type: String, gold: int)
signal reached_base()

func _ready() -> void:
	health = max_health * get_meta("hp_multiplier", 1.0)
	max_health = health
	_load_mesh()

func _physics_process(delta: float) -> void:
	if not is_alive or waypoints.is_empty():
		return

	_move_along_path(delta)

func _move_along_path(delta: float) -> void:
	if current_waypoint_idx >= waypoints.size():
		_reach_base()
		return

	var target = waypoints[current_waypoint_idx]
	var direction = (target - global_position).normalized()
	global_position += direction * speed * delta

	if global_position.distance_to(target) < 0.5:
		current_waypoint_idx += 1

func _reach_base() -> void:
	is_alive = false
	reached_base.emit()
	queue_free()

func take_damage(amount: float, dmg_type: int, attacker_id: String) -> void:
	var type_mult = _get_type_multiplier(dmg_type)
	var armor_reduction = _get_armor_reduction(dmg_type)

	if RelicState.talisman_active:
		type_mult = _invert_type_multiplier(type_mult)

	var final_damage = (amount * type_mult) * (1.0 - armor_reduction)
	final_damage *= RelicState.global_dmg_mult

	health = max(0.0, health - final_damage)
	health_changed.emit(health, max_health)

	if health <= 0.0:
		_die(attacker_id)

func _get_type_multiplier(dmg_type: int) -> float:
	if dmg_type in weaknesses:
		return 1.5
	if dmg_type in resistances:
		return 0.75
	return 1.0

func _invert_type_multiplier(mult: float) -> float:
	if mult == 1.5:
		return 0.75
	if mult == 0.75:
		return 1.5
	return mult

func _get_armor_reduction(dmg_type: int) -> float:
	if dmg_type == DamageTypes.Type.FEU:
		return 0.0
	return armor

func _die(attacker_id: String) -> void:
	is_alive = false
	died.emit(enemy_type, gold_reward)
	queue_free()

func _load_mesh() -> void:
	var model_path = "res://assets/3d_models/%s.glb" % enemy_type.to_lower()
	var mesh_instance: Node3D

	if ResourceLoader.exists(model_path):
		var model = load(model_path)
		mesh_instance = model.instantiate()
	else:
		mesh_instance = PlaceholderFactory.create_enemy_placeholder(enemy_type)

	add_child(mesh_instance)
