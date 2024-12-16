class_name Hitbox
extends Area2D


@export var attack: Attack
@export var hitbox_owner: Node2D


func toggle(on: bool) -> void:
	visible = on
	for child in get_children():
		if child is CollisionShape2D:
			child.disabled = !on
