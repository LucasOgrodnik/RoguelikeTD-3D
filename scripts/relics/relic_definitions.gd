class_name RelicDefinitions

const RELIC_POOL = [
	{
		"id": "oeil_de_lynx",
		"name": "Œil de Lynx",
		"rarity": "common",
		"description": "+10% crit chance for all heroes",
		"effect": "crit_bonus",
		"value": 0.1,
	},
	{
		"id": "amulette_feu",
		"name": "Amulette de Feu",
		"rarity": "common",
		"description": "+15% Fire damage",
		"effect": "damage_bonus",
		"damage_type": "FEU",
		"value": 0.15,
	},
	{
		"id": "lame_aiguisee",
		"name": "Lame Aiguisée",
		"rarity": "common",
		"description": "+15% Slashing damage",
		"effect": "damage_bonus",
		"damage_type": "TRANCHANT",
		"value": 0.15,
	},
	{
		"id": "pointe_aceree",
		"name": "Pointe Acérée",
		"rarity": "common",
		"description": "+15% Piercing damage, -10% Armor of enemies",
		"effect": "piercing_bonus",
		"value": 0.15,
	},
	{
		"id": "grimoire_use",
		"name": "Grimoire Usé",
		"rarity": "common",
		"description": "+15% Magic damage",
		"effect": "damage_bonus",
		"damage_type": "MAGIE",
		"value": 0.15,
	},
	{
		"id": "dents_de_fer",
		"name": "Dents de Fer",
		"rarity": "common",
		"description": "+15% Electric damage",
		"effect": "damage_bonus",
		"damage_type": "ELECTRIQUE",
		"value": 0.15,
	},
	{
		"id": "parchemin_sang",
		"name": "Parchemin de Sang",
		"rarity": "rare",
		"description": "+20% global damage",
		"effect": "global_damage",
		"value": 0.20,
	},
	{
		"id": "grimoire_interdit",
		"name": "Grimoire Interdit",
		"rarity": "rare",
		"description": "+25% Magic damage",
		"effect": "damage_bonus",
		"damage_type": "MAGIE",
		"value": 0.25,
	},
	{
		"id": "coeur_drakon",
		"name": "Cœur de Drakon",
		"rarity": "rare",
		"description": "Enemy HP ×1.75 but deals +50% damage",
		"effect": "dragon_heart",
		"hp_mult": 1.75,
		"dmg_mult": 1.5,
	},
	{
		"id": "talisman_inverse",
		"name": "Talisman Inversé",
		"rarity": "rare",
		"description": "Swap weaknesses/resistances every 10 waves",
		"effect": "invert_types",
	},
	{
		"id": "convergence",
		"name": "Convergence",
		"rarity": "legendary",
		"description": "All heroes trigger ultimates together",
		"effect": "convergence",
	},
	{
		"id": "couronne_chromatique",
		"name": "Couronne Chromatique",
		"rarity": "legendary",
		"description": "Choose 1 hero: ×2 damage for that type",
		"effect": "chromatic_crown",
		"multiplier": 2.0,
	},
	{
		"id": "miroir_sang",
		"name": "Miroir de Sang",
		"rarity": "common",
		"description": "+10% global damage",
		"effect": "global_damage",
		"value": 0.10,
	},
	{
		"id": "sang_anciens",
		"name": "Sang des Anciens",
		"rarity": "rare",
		"description": "+10% global damage",
		"effect": "global_damage",
		"value": 0.10,
	},
]

static func get_relic(relic_id: String) -> Dictionary:
	for relic in RELIC_POOL:
		if relic["id"] == relic_id:
			return relic.duplicate()
	return {}

static func get_random_relic(wave_num: int, current_relics: Array) -> Dictionary:
	var rare_chance = 0.10 + 0.08 * (wave_num / 3.0)
	var leg_chance = 0.05 * (wave_num / 6.0)

	if RelicState.legendary_acquired:
		leg_chance = 0.0

	var roll = randf()

	if roll < leg_chance:
		return _get_legendary()
	elif roll < rare_chance:
		return _get_rare()
	else:
		return _get_common()

static func _get_common() -> Dictionary:
	var commons = RELIC_POOL.filter(func(r): return r["rarity"] == "common")
	return commons[randi() % commons.size()].duplicate()

static func _get_rare() -> Dictionary:
	var rares = RELIC_POOL.filter(func(r): return r["rarity"] == "rare")
	return rares[randi() % rares.size()].duplicate()

static func _get_legendary() -> Dictionary:
	var legs = RELIC_POOL.filter(func(r): return r["rarity"] == "legendary")
	if legs.is_empty():
		return _get_rare()
	return legs[randi() % legs.size()].duplicate()
