class_name SkeletonBonelord
extends EnemyBase

func _ready() -> void:
	enemy_type = "skeleton_bonelord"
	max_health = 500.0
	armor = 0.20
	speed = 1.5
	gold_reward = 80

	weaknesses = [DamageTypes.Type.MAGIE, DamageTypes.Type.FEU]
	resistances = [DamageTypes.Type.PERCANT, DamageTypes.Type.TRANCHANT]

	super._ready()

	waypoints = [
		Vector3(10, 0, 0),
		Vector3(0, 0, 0),
	]
