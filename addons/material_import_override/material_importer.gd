@tool
extends EditorScenePostImportPlugin

# A dictionary of search_material_name: replacement_material_resource_path
@export var overrides: Dictionary = {

}

var material_cache: Dictionary

func _pre_process(scene: Node) -> void:
	iterate(scene)

# Loops through each imported Node looking for PixPal materials to replace with our version.
func iterate(node: Node) -> void:
	# We only care about MeshInstances
	if node is ImporterMeshInstance3D:
		var mesh: ImporterMesh = node.mesh

		# Loop through mesh materials looking for a PixPal
		for index in mesh.get_surface_count():
			var material_name: String = mesh.get_surface_material(index).resource_name

			for search_material_name: String in overrides.keys():
				# Material found. If we have an override defined, replace with our version
				if material_name == search_material_name:
					var replacement: Material = get_replacement_material(search_material_name)
					mesh.set_surface_material(index, replacement)

	for child in node.get_children():
		iterate(child)

# Returns the PixPal ShaderMaterial. Caches for faster retrieval.
func get_replacement_material(search_material_name) -> Material:
	if material_cache.find_key(search_material_name) == null:
		material_cache[search_material_name] = load(overrides[search_material_name])

	return material_cache.get(search_material_name)
