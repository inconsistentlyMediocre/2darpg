extends Node


var is_fullscreen: bool = false


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("fullscreen"):
		toggle_fullscreen()


func set_fullscreen(fullscreen: bool) -> void:
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	is_fullscreen = fullscreen


func toggle_fullscreen() -> void:
	is_fullscreen = !is_fullscreen
	set_fullscreen(is_fullscreen)
