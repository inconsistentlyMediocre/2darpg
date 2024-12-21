class_name Bomb
extends CharacterBody2D


@export var explosion_scene: PackedScene = preload("res://entities/effects/explosion/explosion.tscn")
@export var graphics: Node2D

var initial_speed: float
var throw_angle_degrees: float
var gravity: float = 9.8
var time: float = 0.0

var initial_position: Vector2
var throw_direction: Vector2

var z_axis: float = 0.0
var is_launched: bool = false
var time_mult: float = 10.0

var offset: Vector2


func _physics_process(delta: float) -> void:
	if is_launched:
		time += delta * time_mult
		z_axis = initial_speed * sin(deg_to_rad(throw_angle_degrees)) * time - 0.5 * gravity * pow(time, 2.0)
		if z_axis > 0.0 + offset.y/2.0:
			var x_axis: float = initial_speed * cos(deg_to_rad(throw_angle_degrees)) * time
			#global_position = initial_position + throw_direction * x_axis
			var target: Vector2 = (initial_position + throw_direction * x_axis) - global_position
			velocity = lerp(velocity, target * initial_speed, 1.0)
			graphics.position.y = -z_axis
			move_and_slide()
		else:
			time = 0.0
			is_launched = false
		


func throw(throw_position: Vector2, direction: Vector2, y_offset: float) -> void:
	initial_position = throw_position
	throw_direction = direction
	
	throw_angle_degrees = 45.0
	var desired_distance: float = 80.0
	offset = Vector2(0, y_offset)
	initial_speed = pow(desired_distance * gravity / sin(2.0 * deg_to_rad(throw_angle_degrees)), 0.5)
	global_position = initial_position + offset
	time = 0.0
	z_axis = 0.0
	is_launched = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "explode":
		var explosion: Effect = explosion_scene.instantiate()
		explosion.global_position = global_position
		WorldState.current_level.add_child(explosion)
		queue_free()
