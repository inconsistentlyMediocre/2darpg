class_name RollState
extends State


@export var idle_state: State
@export var move_state: State
@export var attack_state: State

@export var hurtbox: Hurtbox

@export var roll_duration: float = 0.3

var movement: Vector2 = Vector2.ZERO
var attack_queued: bool = false


func enter() -> void:
	super()
	animation_player.animation_finished.connect(_on_animation_finished)
	movement = parent.movement_manager.get_movement_direction().normalized()
	hurtbox.disabled = true
	get_tree().create_timer(roll_duration).timeout.connect(_on_roll_done)


func exit() -> void:
	super()
	animation_player.animation_finished.disconnect(_on_animation_finished)
	animation_finished = false
	hurtbox.disabled = false
	attack_queued = false


func process_physics(delta: float) -> State:
	if get_attack():
		attack_queued = true
	if get_primary_use_item():
		var spawnable: Node2D = parent.current_item_spawnable.instantiate()
		spawnable.global_position = parent.global_position
		WorldState.current_level.add_child(spawnable)
	#parent.velocity = lerp(parent.velocity, movement * speed, delta * velocity_weight)
	if movement != Vector2.ZERO:
		parent.velocity = movement * speed
	else:
		parent.velocity = lerp(parent.velocity, movement * speed, delta * velocity_weight)
	parent.move_and_slide()
	if animation_finished:
		# Prioritize attack
		if attack_queued:
			attack_queued = false
			return attack_state
		if get_movement_input() != Vector2.ZERO:
			return move_state
		return idle_state
	return null


func process_input(event: InputEvent) -> State:
	return null


func _on_roll_done() -> void:
	movement /= 2
