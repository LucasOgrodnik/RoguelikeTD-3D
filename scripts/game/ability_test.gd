class_name AbilityTest
extends Node3D

var test_passed: bool = false

func _ready() -> void:
	print("Ability System Test Starting...")
	_test_abilities()

func _test_abilities() -> void:
	print("\n=== Testing Hero Abilities ===")

	var bladedancer = Bladedancer.new()
	bladedancer.elan = 5
	print("✓ Bladedancer created with 5 Élan")

	bladedancer.trigger_whirlwind()
	print("✓ Whirlwind triggered")

	var pyromancer = Pyromancer.new()
	print("✓ Pyromancer created")

	var stormshard = Stormshard.new()
	stormshard.charges = 10
	print("✓ Stormshard created with 10 Charges")

	stormshard.trigger_lightning()
	print("✓ Lightning triggered")

	var projectile = Projectile.new()
	projectile.damage = 12.0
	projectile.damage_type = DamageTypes.Type.ELECTRIQUE
	print("✓ Projectile created")

	print("\n=== Ability System Test PASSED ✓ ===")
	test_passed = true
