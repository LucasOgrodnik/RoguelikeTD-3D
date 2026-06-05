class_name GoldCalculator

var economy_manager: EconomyManager = EconomyManager.new()

func calculate_kill_gold(enemy_type: String) -> int:
	return economy_manager.get_gold_reward(enemy_type)

func calculate_wave_bonus(wave_num: int) -> int:
	return economy_manager.get_wave_bonus(wave_num)

func calculate_total_gold(kills: Array[String], wave_num: int) -> int:
	var gold = 0

	for enemy_type in kills:
		gold += calculate_kill_gold(enemy_type)

	gold += calculate_wave_bonus(wave_num)

	return gold
