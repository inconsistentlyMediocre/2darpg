class_name Bomb
extends CharacterBody2D


@export var explosion_scene: PackedScene = preload("res://entities/effects/explosion/explosion.tscn")
@export var graphics: Node2D

var is_in_air: bool = false
var air_height: float = 0.0
var start_y: float = 0.0
var air_time: float = 0.2
var apex_over: bool = false

var p0: Vector2
var p1: Vector2
var p2: Vector2
var t: float = 0.0

var deviation_distance: float = 100.0
var deviation_angle: float = 45.0
var destination: Vector2


func _physics_process(delta: float) -> void:
	if not is_in_air:
		return
	if t < 1.0:
		t += 1.0 * delta
	else:
		is_in_air = false
	
	global_position = global_position.bezier_interpolate(p0, p1, p2, t)
	#velocity = lerp(velocity, p2, delta * 25.0)
	#move_and_slide()
	return
	
	if is_in_air:
		print("not over")
		if apex_over:
			global_position.y = move_toward(global_position.y, start_y - air_height, 0.8)
			print("in air")
			if global_position.y > (start_y - air_height) - 0.5:
				print("not air")
				is_in_air = false
	velocity = lerp(velocity, Vector2.ZERO, delta * 5.0)
	move_and_slide()


func set_destination(destination: Vector2) -> void:
	p0 = global_position
	p2 = destination
	var tilted_unit_vector: Vector2 = (p2 - p0).normalized().rotated(deg_to_rad(-deviation_angle))
	p1 = p0 + deviation_distance * tilted_unit_vector


func throw(direction: Vector2) -> void:
	set_destination(direction)
	is_in_air = true
	velocity = Vector2.ZERO
	return
	#velocity = direction * 200


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "explode":
		var explosion: Effect = explosion_scene.instantiate()
		explosion.global_position = global_position
		WorldState.current_level.add_child(explosion)
		queue_free()
