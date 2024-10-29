extends State


@export var move_state: State
@export var attack_state: State
@export var talk_state: State


func process_input(event: InputEvent) -> State:
	#if get_movement_input() != Vector2.ZERO:
		#return move_state
	#if get_attack():
		#return attack_state
	return null


func process_frame(delta: float) -> State:
	return null


func process_physics(delta: float) -> State:
	if get_movement_input() != Vector2.ZERO:
		return move_state
	if get_interaction():
		return talk_state
	if get_attack():
		return attack_state
	parent.velocity = lerp(parent.velocity, Vector2.ZERO, delta * velocity_weight)
	parent.move_and_slide()
	return null
