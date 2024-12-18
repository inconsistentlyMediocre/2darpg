class_name HoldState
extends MoveState


@export var offset: Vector2 = Vector2(-8, -12)

var held_item: Node2D
var original_animation_name: String = ""


func enter() -> void:
	super()
	original_animation_name = animation_name


func exit() -> void:
	super()
	held_item = null
	animation_name = original_animation_name


func process_physics(delta: float) -> State:
	if Utils.validate([held_item]):
		held_item.position = offset
	
	if get_primary_use_item():
		parent.remove_child(held_item)
		held_item.position = Vector2.ZERO
		held_item.global_position = parent.global_position
		if movement_manager.facing_direction != Vector2.DOWN and movement_manager.facing_direction != Vector2.UP:
			held_item.global_position.y += offset.y
		#held_item.is_in_air = true
		held_item.throw(parent.global_position + movement_manager.facing_direction * 100)
		WorldState.current_level.add_child(held_item)
		return idle_state
	
	if get_secondary_use_item():
		parent.remove_child(held_item)
		held_item.position = Vector2.ZERO
		held_item.global_position = parent.global_position
		WorldState.current_level.add_child(held_item)
		return idle_state
	
	var attack: Attack = get_hit()
	if attack:
		hurt_state.attack = attack
		return hurt_state
	var movement: Vector2 = get_movement_input()
	if movement == Vector2.ZERO:
		parent.velocity = lerp(parent.velocity, Vector2.ZERO, delta * idle_state.velocity_weight)
		animation_name = "idle"
		play_animation()
	else:
		animation_name = original_animation_name
		play_animation()
	parent.velocity = lerp(parent.velocity, movement * speed, delta * velocity_weight)
	parent.move_and_slide()
	return null
