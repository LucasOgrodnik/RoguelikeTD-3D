class_name DamageCalculator

static func calculate_damage(
	base_damage: float,
	dmg_type: int,
	target_armor: float,
	target_weaknesses: Array[int],
	target_resistances: Array[int],
	crit_chance: float = 0.0
) -> float:
	var dmg = base_damage

	if randf() < crit_chance:
		dmg *= 1.5

	var type_mult = _get_type_multiplier(dmg_type, target_weaknesses, target_resistances)
	if RelicState.talisman_active:
		type_mult = _invert_type_multiplier(type_mult)

	var armor_reduction = _get_armor_reduction(dmg_type, target_armor)

	var final_damage = (dmg * type_mult) * (1.0 - armor_reduction)
	final_damage *= RelicState.global_dmg_mult

	return final_damage

static func _get_type_multiplier(dmg_type: int, weaknesses: Array[int], resistances: Array[int]) -> float:
	if dmg_type in weaknesses:
		return 1.5
	if dmg_type in resistances:
		return 0.75
	return 1.0

static func _invert_type_multiplier(mult: float) -> float:
	if mult == 1.5:
		return 0.75
	if mult == 0.75:
		return 1.5
	return mult

static func _get_armor_reduction(dmg_type: int, armor: float) -> float:
	if dmg_type == DamageTypes.Type.FEU:
		return 0.0
	return armor
