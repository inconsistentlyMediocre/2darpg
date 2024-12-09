class_name StateMachine
extends Node


@export var starting_state: State
@export var parent: CharacterBody2D
@export var animation_player: AnimationPlayer
@export var movement_manager: MovementManager
@export var hp_manager: HPManager

var current_state: State
var states: Array[State]


func _ready() -> void:
	for child in get_children():
		if child is State:
			states.append(child)


func init() -> void:
	for state in states:
		state.parent = parent
		state.animation_player = animation_player
		state.movement_manager = movement_manager
		state.hp_manager = hp_manager
	change_state(starting_state)


func change_state(new_state: State) -> void:
	if Utils.validate([current_state]):
		current_state.exit()
	
	current_state = new_state
	current_state.enter()


func process_physics(delta: float) -> void:
	var new_state: State = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)


func process_input(event: InputEvent) -> void:
	var new_state: State = current_state.process_input(event)
	if new_state:
		change_state(new_state)


func process_frame(delta: float) -> void:
	var new_state: State = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
