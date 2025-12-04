@tool
extends EditorPlugin


func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _enter_tree() -> void:
	add_custom_type("TilemapRendererWZ", "Node3D", load("res://addons/workzone/nodes/tilemapRendererWz.gd"), load("res://icon.svg"))
	add_custom_type("PlayerWZ", "CharacterBody3D", load("res://addons/workzone/nodes/playerWz.gd"), load("res://icon.svg"))
	# Initialization of the plugin goes here.
	pass


func _exit_tree() -> void:
	remove_custom_type("TilemapWZ")
	# Clean-up of the plugin goes here.
	pass
