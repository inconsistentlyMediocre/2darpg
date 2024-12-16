class_name Player
extends MovingEntity


#@onready var state_machine: StateMachine = $Components/StateMachine
#@onready var animation_player: AnimationPlayer = $AnimationPlayer
#@onready var hp_manager: HPManager = $Components/HPManager
#@onready var hurtbox: Hurtbox = $Components/Hurtbox

var current_item_spawnable: PackedScene = preload("res://entities/items/active/bomb.tscn")


func _unhandled_input(event: InputEvent) -> void:
	if Utils.validate([state_machine]):
		state_machine.process_input(event)


func kill() -> void:
	queue_free()
