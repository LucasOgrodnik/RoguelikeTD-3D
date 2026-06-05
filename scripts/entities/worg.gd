class_name Worg
extends EnemyBase

func _ready() -> void:
	enemy_type = "worg"
	max_health = 45.0
	armor = 0.05
	speed = 5.8
	gold_reward = 10

	weaknesses = [DamageTypes.Type.FEU, DamageTypes.Type.MAGIE]
	resistances = [DamageTypes.Type.PERCANT, DamageTypes.Type.TRANCHANT]

	super._ready()

	waypoints = [
		Vector3(10, 0, 0),
		Vector3(0, 0, 0),
	]
