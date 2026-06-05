class_name PlaceholderFactory

static func create_hero_placeholder(hero_name: String) -> Node3D:
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = BoxMesh.new()
	mesh_instance.mesh.size = Vector3(1.0, 1.5, 1.0)

	var material = StandardMaterial3D.new()
	material.albedo_color = Color.BLUE
	mesh_instance.material_override = material

	return mesh_instance


static func create_enemy_placeholder(enemy_type: String) -> Node3D:
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = BoxMesh.new()
	mesh_instance.mesh.size = Vector3(0.8, 1.2, 0.8)

	var material = StandardMaterial3D.new()
	material.albedo_color = Color.RED
	mesh_instance.material_override = material

	return mesh_instance


static func create_projectile_placeholder() -> Node3D:
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = SphereMesh.new()
	mesh_instance.mesh.radius = 0.2

	var material = StandardMaterial3D.new()
	material.albedo_color = Color.YELLOW
	mesh_instance.material_override = material

	return mesh_instance


static func create_terrain_placeholder() -> Node3D:
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = PlaneMesh.new()
	mesh_instance.mesh.size = Vector2(20.0, 20.0)

	var material = StandardMaterial3D.new()
	material.albedo_color = Color.GRAY
	mesh_instance.material_override = material

	return mesh_instance
