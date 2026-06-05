class_name RelicEffects

static func apply_damage_bonus(base_damage: float, damage_type: int) -> float:
	var bonus = 1.0

	match damage_type:
		DamageTypes.Type.FEU:
			if RelicState.has_relic("Amulette de Feu"):
				bonus *= 1.15
			if RelicState.has_relic("Grimoire Interdit"):
				bonus *= 1.25
		DamageTypes.Type.TRANCHANT:
			if RelicState.has_relic("Lame Aiguisée"):
				bonus *= 1.15
		DamageTypes.Type.PERCANT:
			if RelicState.has_relic("Pointe Acérée"):
				bonus *= 1.15
		DamageTypes.Type.MAGIE:
			if RelicState.has_relic("Grimoire Usé"):
				bonus *= 1.15
		DamageTypes.Type.ELECTRIQUE:
			if RelicState.has_relic("Dents de Fer"):
				bonus *= 1.15

	return base_damage * bonus

static func apply_global_damage_bonus(base_damage: float) -> float:
	if RelicState.has_relic("Parchemin de Sang"):
		return base_damage * 1.2
	if RelicState.has_relic("Miroir de Sang"):
		return base_damage * 1.1
	if RelicState.has_relic("Sang des Anciens"):
		return base_damage * 1.1

	return base_damage

static func apply_crit_bonus() -> float:
	var bonus = 0.0
	if RelicState.has_relic("Œil de Lynx"):
		bonus += 0.1
	return bonus

static func apply_chromatic_boost(hero_name: String, damage_type: int) -> float:
	if RelicState.has_relic("Couronne Chromatique"):
		if RelicState.chosen_chromatic_hero == hero_name:
			return 2.0
	return 1.0

static func should_trigger_convergence() -> bool:
	return RelicState.has_relic("Convergence")

static func apply_enemy_hp_mult() -> float:
	if RelicState.has_relic("Cœur de Drakon"):
		return 1.75
	return 1.0

static func apply_armor_reduction(armor: float) -> float:
	if RelicState.has_relic("Pointe Acérée"):
		armor *= 0.9
	return armor
