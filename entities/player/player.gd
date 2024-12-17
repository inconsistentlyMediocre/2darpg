class_name Player
extends MovingEntity


#@onready var state_machine: StateMachine = $Components/StateMachine
#@onready var animation_player: AnimationPlayer = $AnimationPlayer
#@onready var hp_manager: HPManager = $Components/HPManager
#@onready var hurtbox: Hurtbox = $Components/Hurtbox

var current_item_spawnable: PackedScene = preload("res://entities/items/active/bomb.tscn")

@onready var camera_2d: Camera2D = $Camera2D


func _ready() -> void:
	super()
	
	camera_2d.limit_left = 0
	camera_2d.limit_top = 0
	if WorldState.current_level:
		camera_2d.limit_right = WorldState.current_level.map_size.x
		camera_2d.limit_bottom = WorldState.current_level.map_size.y


func _unhandled_input(event: InputEvent) -> void:
	if Utils.validate([state_machine]):
		state_machine.process_input(event)


func kill() -> void:
	queue_free()
