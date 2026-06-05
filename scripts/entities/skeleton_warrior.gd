class_name SkeletonWarrior
extends EnemyBase

func _ready() -> void:
	enemy_type = "skeleton_warrior"
	max_health = 60.0
	armor = 0.0
	speed = 3.3
	gold_reward = 10

	weaknesses = [DamageTypes.Type.MAGIE, DamageTypes.Type.FEU]
	resistances = [DamageTypes.Type.PERCANT, DamageTypes.Type.TRANCHANT]

	super._ready()

	waypoints = [
		Vector3(10, 0, 0),
		Vector3(0, 0, 0),
	]
