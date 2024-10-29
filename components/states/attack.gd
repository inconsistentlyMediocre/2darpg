extends State


@export var idle_state: State
@export var move_state: State

var animation_done: bool = false


func enter() -> void:
	super()
	animation_player.animation_finished.connect(func(anim_name: String) -> void: animation_done = true)


func process_physics(delta: float) -> State:
	parent.velocity = lerp(parent.velocity, Vector2.ZERO, delta * velocity_weight)
	parent.move_and_slide()
	if animation_done:
		animation_done = false
		if super.get_movement_input() != Vector2.ZERO:
			return move_state
		return idle_state
	return null


func get_interaction() -> bool:
	return false
