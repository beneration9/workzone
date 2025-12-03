extends Node3D
class_name TilemapRendererWZ

@export var tilemap:TilemapWZ
var shd:Shader = preload("res://ursc/spatial/standard/standard_opaque.gdshader")
var tile:PackedScene = preload("res://addons/workzone/scenes/tile.tscn")

func _ready() -> void:
	if !Engine.is_editor_hint():
		for i in tilemap.tiles:
			var newTile = tile.instantiate()
			var mat = ShaderMaterial.new()
			mat.shader = shd
			mat.set_shader_parameter("albedo_texture", tilemap.tileset.tiles[i.tileIndex])
			newTile.get_node("Cube").set_surface_override_material(0, mat)
			newTile.position = i.position
			add_child(newTile)
