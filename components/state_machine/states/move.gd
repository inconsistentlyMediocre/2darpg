class_name MoveState
extends State


@export var idle_state: State
@export var attack_state: State
@export var talk_state: State
@export var roll_state: State
@export var hurt_state: State
@export var hold_state: State


func process_input(event: InputEvent) -> State:
	#if get_attack():
		#return attack_state
	return null


func process_frame(delta: float) -> State:
	return null


func process_physics(delta: float) -> State:
	if get_attack():
		return attack_state
	if get_roll():
		return roll_state
	if get_interaction():
		return talk_state
	if get_primary_use_item():
		var spawnable: Node2D = parent.current_item_spawnable.instantiate()
		parent.add_child(spawnable)
		hold_state.held_item = spawnable
		return hold_state
		#spawnable.global_position = parent.global_position
		#WorldState.current_level.add_child(spawnable)
	
	var attack: Attack = get_hit()
	if attack:
		hurt_state.attack = attack
		return hurt_state
	var movement: Vector2 = get_movement_input()
	if movement == Vector2.ZERO:
		return idle_state
	parent.velocity = lerp(parent.velocity, movement * speed, delta * velocity_weight)
	parent.move_and_slide()
	return null
