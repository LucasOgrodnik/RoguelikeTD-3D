class_name TerrainManager
extends Node3D

var placement_positions: Array[Vector3] = []
var debug_mode: bool = false

func _ready() -> void:
	_generate_placement_grid()

func _generate_placement_grid() -> void:
	var grid_width = 4
	var grid_height = 2
	var spacing = 3.0

	placement_positions.clear()

	for x in range(grid_width):
		for z in range(grid_height):
			var pos = Vector3(
				-grid_width * spacing / 2.0 + x * spacing,
				0.0,
				-grid_height * spacing / 2.0 + z * spacing
			)
			placement_positions.append(pos)

	print("Placement grid generated: %d positions" % placement_positions.size())

func get_available_positions() -> Array[Vector3]:
	return placement_positions.duplicate()

func get_nearest_position(world_pos: Vector3) -> Vector3:
	var nearest = placement_positions[0]
	var min_dist = world_pos.distance_to(nearest)

	for pos in placement_positions:
		var dist = world_pos.distance_to(pos)
		if dist < min_dist:
			nearest = pos
			min_dist = dist

	return nearest

func _draw() -> void:
	if debug_mode:
		for pos in placement_positions:
			draw_sphere(pos, 0.3, Color.GREEN, 8)

func draw_sphere(center: Vector3, radius: float, color: Color, lats: int) -> void:
	var mesh = SphereMesh.new()
	mesh.radius = radius
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = mesh
	mesh_instance.global_position = center
	var material = StandardMaterial3D.new()
	material.albedo_color = color
	mesh_instance.material_override = material
	add_child(mesh_instance)
