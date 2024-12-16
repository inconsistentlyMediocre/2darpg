class_name Bomb
extends Node2D


@export var explosion_scene: PackedScene = preload("res://entities/effects/explosion/explosion.tscn")
@export var graphics: Node2D


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "explode":
		var explosion: Effect = explosion_scene.instantiate()
		explosion.global_position = global_position
		WorldState.current_level.add_child(explosion)
