class_name Hitbox
extends Area2D


@export var attack: Attack
@export var hitbox_owner: CharacterBody2D


func toggle(on: bool) -> void:
	for child in get_children():
		if child is CollisionShape2D:
			child.disabled = !on
