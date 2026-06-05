class_name Bladedancer
extends HeroBase

var elan: int = 0
var elan_max: int = 8

func _ready() -> void:
	hero_name = "Bladedancer"
	damage = 8.0
	attack_speed = 1.2
	attack_range = 90.0
	crit_chance = 0.0

	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	elan = min(elan, elan_max)

func gain_elan(amount: int) -> void:
	elan = min(elan + amount, elan_max)

func use_elan(amount: int) -> bool:
	if elan >= amount:
		elan -= amount
		return true
	return false

func trigger_whirlwind() -> void:
	if use_elan(4):
		var enemies_node = get_node_or_null("../../GameWorld/Enemies")
		if enemies_node:
			for enemy in enemies_node.get_children():
				if enemy is Node3D and enemy.has_method("take_damage"):
					var dmg = damage * 1.5
					enemy.take_damage(dmg, DamageTypes.Type.TRANCHANT, hero_name)
		trigger_ultimate()
