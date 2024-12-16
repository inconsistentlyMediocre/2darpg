class_name PlayerMovementManager
extends MovementManager


@export var use_analog_movement: bool = false
@export var interaction_component: Interaction


func get_movement_direction() -> Vector2:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	if not use_analog_movement:
		direction = direction.normalized()
	set_direction_string(direction)
	if direction != Vector2.ZERO:
		facing_direction = direction.normalized()
	
	return direction


func get_attack() -> bool:
	return Input.is_action_just_pressed("attack")


func get_interaction() -> bool:
	if Utils.validate([interaction_component]):
		if Input.is_action_just_pressed("action"):
			return interaction_component.interact()
	return false


func get_roll() -> bool:
	return Input.is_action_just_pressed("roll")


func get_use_item() -> bool:
	return Input.is_action_just_pressed("use_item")
