@tool
class_name TextureFramesRect
extends TextureRect


@export var texture_frames: SpriteFrames:
	set(value):
		texture_frames = value
		max_frames = texture_frames.get_frame_count("default") - 1
		current_frame = 0
@export var current_frame: int:
	set(value):
		current_frame = value
		current_frame = clamp(current_frame, 0, max_frames)
		if is_instance_valid(texture_frames) and texture_frames:
			texture = texture_frames.get_frame_texture("default", current_frame)

var max_frames: int = 0
