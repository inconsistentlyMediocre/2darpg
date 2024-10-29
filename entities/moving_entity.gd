class_name MovingEntity
extends CharacterBody2D


@export var state_machine: StateMachine
@export var movement_manager: MovementManager
@export var hp_manager: HPManager
@export var hurtbox: Hurtbox
@export var animation_player: AnimationPlayer


func _ready() -> void:
	if Utils.validate([state_machine]):
		state_machine.init()
	if Utils.validate([hurtbox]):
		hurtbox.parent = self
	if Utils.validate([hp_manager]):
		hp_manager.died.connect(kill)


func _physics_process(delta: float) -> void:
	if Utils.validate([state_machine]):
		state_machine.process_physics(delta)


func _process(delta: float) -> void:
	if Utils.validate([state_machine]):
		state_machine.process_frame(delta)


func kill() -> void:
	pass
