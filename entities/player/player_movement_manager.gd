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
		set_facing_direction()
		#if facing_direction.x == 0 and direction.abs().x > 0.5:
			#facing_direction.x = 1.0
		#if facing_direction.y == 0 and direction.abs().y > 0.5:
			#facing_direction.y = 1.0
	
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
