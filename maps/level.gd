class_name Level
extends Node2D


@export var level_name: String


func _ready() -> void:
	WorldState.current_level = self
