class_name SkeletonKnight
extends EnemyBase

func _ready() -> void:
	enemy_type = "skeleton_knight"
	max_health = 180.0
	armor = 0.15
	speed = 2.5
	gold_reward = 25

	weaknesses = [DamageTypes.Type.MAGIE, DamageTypes.Type.FEU]
	resistances = [DamageTypes.Type.PERCANT, DamageTypes.Type.TRANCHANT]

	super._ready()

	waypoints = [
		Vector3(10, 0, 0),
		Vector3(0, 0, 0),
	]
