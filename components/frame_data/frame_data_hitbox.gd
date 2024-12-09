@tool
class_name FrameDataHitbox
extends CollisionShape2D


@export var btn_add_hitbox_to_frame: bool = false:
	set(value):
		btn_add_hitbox_to_frame = false

@export var btn_remove_hitbox: bool = false:
	set(value):
		btn_remove_hitbox = false

@export var attack: Attack

# Node name should be Frame_[frame_index]_Hitbox_[hitbox_index]
var frame_index: int
var hitbox_index: int

var type: FrameDataObject.FrameType
