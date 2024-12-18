class_name TalkState
extends State


@export var idle_state: State

var done: bool = false


func _ready() -> void:
	Dialogic.timeline_ended.connect(func() -> void: done = true)


func process_physics(delta: float) -> State:
	if done:
		done = false
		return idle_state
	return null
