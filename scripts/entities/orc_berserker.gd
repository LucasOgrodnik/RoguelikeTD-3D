class_name OrcBerserker
extends EnemyBase

func _ready() -> void:
	enemy_type = "orc_berserker"
	max_health = 220.0
	armor = 0.15
	speed = 3.2
	gold_reward = 30

	weaknesses = [DamageTypes.Type.FEU, DamageTypes.Type.MAGIE]
	resistances = [DamageTypes.Type.PERCANT, DamageTypes.Type.TRANCHANT]

	super._ready()

	waypoints = [
		Vector3(10, 0, 0),
		Vector3(0, 0, 0),
	]
