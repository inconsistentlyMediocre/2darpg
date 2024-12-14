class_name Player
extends MovingEntity


#@onready var state_machine: StateMachine = $Components/StateMachine
#@onready var animation_player: AnimationPlayer = $AnimationPlayer
#@onready var hp_manager: HPManager = $Components/HPManager
#@onready var hurtbox: Hurtbox = $Components/Hurtbox


func _ready() -> void:
	super()
	add_to_group("Player")


func _unhandled_input(event: InputEvent) -> void:
	if Utils.validate([state_machine]):
		state_machine.process_input(event)


func kill() -> void:
	queue_free()
