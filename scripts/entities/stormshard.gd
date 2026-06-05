class_name Stormshard
extends HeroBase

var charges: int = 0
var charges_max: int = 15

func _ready() -> void:
	hero_name = "Stormshard"
	damage = 12.0
	attack_speed = 1.1
	attack_range = 100.0
	crit_chance = 0.0

	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	charges = min(charges, charges_max)

func gain_charge(amount: int) -> void:
	charges = min(charges + amount, charges_max)

func use_charge(amount: int) -> bool:
	if charges >= amount:
		charges -= amount
		return true
	return false

func _perform_attack(target: Node3D) -> void:
	var dmg = _roll_dmg()

	if target.has_method("take_damage"):
		target.take_damage(dmg, DamageTypes.Type.ELECTRIQUE, hero_name)

	gain_charge(1)

	attack_cooldown = 1.0 / attack_speed
	attacked.emit(target, dmg)

func trigger_lightning() -> void:
	if charges >= 10:
		var enemies_node = get_node_or_null("../../GameWorld/Enemies")
		if enemies_node:
			for enemy in enemies_node.get_children():
				if enemy is Node3D and enemy.has_method("take_damage"):
					var distance = global_position.distance_to(enemy.global_position)
					if distance <= attack_range * 1.5:
						var dmg = damage * 2.5
						enemy.take_damage(dmg, DamageTypes.Type.ELECTRIQUE, hero_name)
		charges = 0
		trigger_ultimate()
