class_name OrcWarchief
extends EnemyBase

func _ready() -> void:
	enemy_type = "orc_warchief"
	max_health = 650.0
	armor = 0.20
	speed = 1.6
	gold_reward = 90

	weaknesses = [DamageTypes.Type.FEU, DamageTypes.Type.MAGIE]
	resistances = [DamageTypes.Type.PERCANT, DamageTypes.Type.TRANCHANT]

	super._ready()

	waypoints = [
		Vector3(10, 0, 0),
		Vector3(0, 0, 0),
	]
