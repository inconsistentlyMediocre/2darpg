class_name Effect
extends Node2D


@export var graphics: Node2D

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()