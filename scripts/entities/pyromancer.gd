class_name Pyromancer
extends HeroBase

var combustible_stacks: Dictionary = {}

func _ready() -> void:
	hero_name = "Pyromancer"
	damage = 15.0
	attack_speed = 1.0
	attack_range = 110.0
	crit_chance = 0.0

	super._ready()

func _perform_attack(target: Node3D) -> void:
	var dmg = _roll_dmg()

	if target.has_method("take_damage"):
		target.take_damage(dmg, DamageTypes.Type.FEU, hero_name)

	_add_combustible_stack(target, 1)

	attack_cooldown = 1.0 / attack_speed
	attacked.emit(target, dmg)

func _add_combustible_stack(target: Node3D, amount: int) -> void:
	var target_id = target.get_instance_id()
	if target_id not in combustible_stacks:
		combustible_stacks[target_id] = 0
	combustible_stacks[target_id] += amount

func trigger_ignition() -> void:
	var enemies_node = get_node_or_null("../../GameWorld/Enemies")
	if enemies_node:
		for enemy in enemies_node.get_children():
			if enemy is Node3D and enemy.has_method("take_damage"):
				var target_id = enemy.get_instance_id()
				var stacks = combustible_stacks.get(target_id, 0)
				if stacks >= 3:
					var dmg = damage * 2.0 * stacks
					enemy.take_damage(dmg, DamageTypes.Type.FEU, hero_name)
					combustible_stacks.erase(target_id)

	trigger_ultimate()
