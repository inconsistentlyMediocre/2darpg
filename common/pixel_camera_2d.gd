class_name PixelCamera2D
extends Node2D


@export var active: bool = true
@export var smoothing: bool = false
@export var smoothing_speed: float = 5.0

var window: Window
var internal_resolution: Vector2i = Vector2i(320, 180)
var scale_factor: int = 0
var camera_position: Vector2
var smoothed_camera_position: Vector2


func _ready() -> void:
	if not active:
		return
	window = get_window()
	internal_resolution = window.content_scale_size
	
	var current_window_size: Vector2i = DisplayServer.window_get_size()
	scale_factor = current_window_size.y / internal_resolution.y
	#camera_position = get_parent().global_position - Vector2(internal_resolution) / 2
	smoothed_camera_position = get_parent().global_position - Vector2(internal_resolution) / 2


func _process(delta: float) -> void:
	if not active:
		return
	var new_pos: Vector2 = get_parent().global_position - Vector2(internal_resolution) / 2
	
	if smoothing:
		new_pos = new_pos.snappedf( 1.0 / scale_factor)
		var c: float = smoothing_speed * delta
		smoothed_camera_position = ((new_pos - smoothed_camera_position) * c) + smoothed_camera_position
		camera_position = smoothed_camera_position
	else:
		camera_position = new_pos
	var xform: Transform2D
	xform.origin = camera_position
	window.canvas_transform = xform.affine_inverse()
