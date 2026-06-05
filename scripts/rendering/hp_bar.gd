class_name HpBar
extends CanvasLayer

var entity: Node3D = null
var canvas: CanvasItem = null
var viewport_size: Vector2 = Vector2.ZERO

var current_health: float = 100.0
var max_health: float = 100.0

func _ready() -> void:
	viewport_size = get_viewport().get_visible_rect().size
	canvas = Control.new()
	canvas.set_anchors_preset(Control.PRESET_TOP_LEFT)
	add_child(canvas)

func setup(entity_ref: Node3D, initial_health: float, max_hp: float) -> void:
	entity = entity_ref
	current_health = initial_health
	max_health = max_hp

	if entity.has_signal("health_changed"):
		entity.health_changed.connect(_on_health_changed)

func _process(_delta: float) -> void:
	if not entity or not is_node_alive(entity):
		queue_free()
		return

	canvas.queue_redraw()

func _on_health_changed(new_health: float, new_max: float) -> void:
	current_health = new_health
	max_health = new_max

func is_node_alive(node: Node) -> bool:
	return is_instance_valid(node) and node.get_parent() != null

func _draw() -> void:
	if not entity:
		return

	var screen_pos = get_world_2d().canvas_transform * entity.global_position
	var bar_width = 40.0
	var bar_height = 5.0
	var bar_x = screen_pos.x - bar_width / 2.0
	var bar_y = screen_pos.y - 30.0

	var health_percent = clamp(current_health / max_health, 0.0, 1.0)

	canvas.draw_rect(Rect2(bar_x, bar_y, bar_width, bar_height), Color.DARK_GRAY)
	canvas.draw_rect(Rect2(bar_x, bar_y, bar_width * health_percent, bar_height), Color.RED)
