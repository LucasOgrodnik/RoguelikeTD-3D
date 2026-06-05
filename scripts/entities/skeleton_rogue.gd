class_name SkeletonRogue
extends EnemyBase

func _ready() -> void:
	enemy_type = "skeleton_rogue"
	max_health = 40.0
	armor = 0.0
	speed = 5.0
	gold_reward = 8

	weaknesses = [DamageTypes.Type.MAGIE, DamageTypes.Type.FEU]
	resistances = [DamageTypes.Type.PERCANT, DamageTypes.Type.TRANCHANT]

	super._ready()

	waypoints = [
		Vector3(10, 0, 0),
		Vector3(0, 0, 0),
	]
