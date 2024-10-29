class_name PlayerMovementManager
extends MovementManager


@export var interaction_component: Interaction


func get_movement_direction() -> Vector2:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	set_direction_string(direction)
	
	return direction


func get_attack() -> bool:
	return Input.is_action_just_pressed("attack")


func get_interaction() -> bool:
	if Utils.validate([interaction_component]):
		if Input.is_action_just_pressed("action"):
			return interaction_component.interact()
	return false
