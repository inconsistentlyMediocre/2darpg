class_name Level
extends Node2D


@export var level_name: String
@export var tilemap: Node2D
var map_size: Vector2 = Vector2.ZERO


func _enter_tree() -> void:
	WorldState.current_level = self
	#await WorldState.current_level.ready
	if tilemap:
		for layer in tilemap.get_children():
			if layer is TileMapLayer:
				var size: Vector2 = layer.get_used_rect().size * layer.tile_set.tile_size
				if size > map_size:
					map_size = size
