class_name CameraManager
extends Node3D

var camera: Camera3D

func _ready() -> void:
	camera = $Camera3D
	if not camera:
		push_error("CameraManager: Camera3D child not found")
		return

	setup_isometric_view()


func setup_isometric_view() -> void:
	camera.projection = Camera3D.PROJECTION_ORTHOGONAL
	camera.size = 12.0

	global_position = Vector3(-20, 15, 20)
	camera.look_at(Vector3.ZERO, Vector3.UP)


func set_camera_zoom(zoom_level: float) -> void:
	if camera:
		camera.size = clamp(zoom_level, 5.0, 20.0)


func get_camera_zoom() -> float:
	return camera.size if camera else 12.0
