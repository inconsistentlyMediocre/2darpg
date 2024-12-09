@tool
class_name AttackFrameData
extends Node2D


@export var btn_add_frame: bool = false:
	set(value):
		#btn_add_frame = false
		add_frame()

@export var btn_clear_frame_data: bool = false:
	set(value):
		btn_clear_frame_data = false

#@export var frame_data_frames: Array[FrameDataObject]


var current_index: int = 0
var frame_count: int = 0
var current_frame: AttackFrame


func _enter_tree() -> void:
	for child in get_children():
		if child is AttackFrame:
			child.toggle(false)


func start() -> void:
	current_frame = get_child(current_index)
	if current_frame is AttackFrame:
		current_frame.toggle(true)


func end() -> void:
	current_index = 0
	current_frame = get_child(current_index)


func next_frame() -> void:
	current_frame.toggle(false)
	current_index += 1
	current_index = clamp(current_index, 0, get_child_count())
	current_frame = get_child(current_index)
	if current_frame is AttackFrame:
		current_frame.toggle(true)


func add_frame() -> void:
	var new_frame: AttackFrame = AttackFrame.new()
	new_frame.name = "Frame_" + str(get_child_count())
	new_frame.hitbox_owner = get_tree().edited_scene_root
	add_child(new_frame)
	new_frame.owner = get_tree().edited_scene_root
