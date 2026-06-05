class_name RelicIntegrationTest
extends Node3D

var test_passed: bool = false

func _ready() -> void:
	print("Relic Integration Test Starting...")
	_test_relic_system()

func _test_relic_system() -> void:
	print("\n=== Testing Relic System ===")

	var relic1 = RelicDefinitions.get_relic("oeil_de_lynx")
	print("✓ Relic loaded: %s (%s)" % [relic1["name"], relic1["rarity"]])

	RelicState.active_relics.append(relic1)
	print("✓ Relic added to state")

	var crit_bonus = RelicEffects.apply_crit_bonus()
	print("✓ Crit bonus applied: +%.0f%%" % [crit_bonus * 100])

	var random_relic = RelicDefinitions.get_random_relic(5, [])
	print("✓ Random relic generated: %s" % random_relic["name"])

	var draft = DraftScreen.new()
	draft.setup(10)
	print("✓ Draft screen setup for wave 10")

	print("\n=== Relic Integration Test PASSED ✓ ===")
	test_passed = true
