class_name MovementManager
extends Node


signal direction_updated

const DOWN_STRING: String = "down"
const UP_STRING: String = "up"
const LEFT_STRING: String = "left"
const RIGHT_STRING: String = "right"

var direction_string: String = DOWN_STRING
var facing_direction: Vector2 = Vector2.ZERO

var current_string: String = direction_string:
	set(value):
		current_string = value
		direction_updated.emit()


func _ready() -> void:
	match direction_string:
		DOWN_STRING:
			facing_direction = Vector2.DOWN
		UP_STRING:
			facing_direction = Vector2.UP
		LEFT_STRING:
			facing_direction = Vector2.LEFT
		RIGHT_STRING:
			facing_direction = Vector2.RIGHT


func get_movement_direction() -> Vector2:
	return Vector2.ZERO


func get_attack() -> bool:
	return false


func get_interaction() -> bool:
	return false


func get_roll() -> bool:
	return false


func get_use_item() -> bool:
	return false


func set_direction_string(direction: Vector2) -> void:
	if direction.x != 0.0:
		if direction.x > 0.0:
			direction_string = RIGHT_STRING
		elif direction.x < 0.0:
			direction_string = LEFT_STRING
	if direction.y != 0.0 and abs(direction.y) >= abs(direction.x):
		if direction.y > 0.0:
			direction_string = DOWN_STRING
		elif direction.y < 0.0:
			direction_string = UP_STRING
	if direction_string != current_string:
		current_string = direction_string
