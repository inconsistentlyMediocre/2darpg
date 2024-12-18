class_name AttackState
extends State


@export var idle_state: State
@export var move_state: State
@export var hurt_state: State

# Should it be a slice, thrust, etc
@export var attack_type: int


func enter() -> void:
	super()
	animation_player.animation_finished.connect(_on_animation_finished)


func exit() -> void:
	super()
	animation_player.animation_finished.disconnect(_on_animation_finished)
	animation_finished = false


func process_physics(delta: float) -> State:
	var attack: Attack = get_hit()
	if attack:
		hurt_state.attack = attack
		return hurt_state
	parent.velocity = lerp(parent.velocity, Vector2.ZERO, delta * velocity_weight)
	parent.move_and_slide()
	if animation_finished:
		if super.get_movement_input() != Vector2.ZERO:
			return move_state
		return idle_state
	return null


func get_interaction() -> bool:
	return false
