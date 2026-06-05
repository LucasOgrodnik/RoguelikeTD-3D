class_name DamageNumber
extends Node3D

var damage_amount: float = 0.0
var lifetime: float = 1.5
var elapsed: float = 0.0
var label: Label3D = null

func _ready() -> void:
	label = Label3D.new()
	label.text = str(int(damage_amount))
	label.font_size = 32
	add_child(label)

func _process(delta: float) -> void:
	elapsed += delta
	global_position.y += delta * 2.0

	var progress = elapsed / lifetime
	if label:
		label.modulate.a = 1.0 - progress

	if elapsed >= lifetime:
		queue_free()

func set_damage(amount: float) -> void:
	damage_amount = amount
	if label:
		label.text = str(int(amount))
