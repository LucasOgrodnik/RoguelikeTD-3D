class_name OrcWarrior
extends EnemyBase

func _ready() -> void:
	enemy_type = "orc_warrior"
	max_health = 80.0
	armor = 0.15
	speed = 2.8
	gold_reward = 12

	weaknesses = [DamageTypes.Type.FEU, DamageTypes.Type.MAGIE]
	resistances = [DamageTypes.Type.PERCANT, DamageTypes.Type.TRANCHANT]

	super._ready()

	waypoints = [
		Vector3(10, 0, 0),
		Vector3(0, 0, 0),
	]
