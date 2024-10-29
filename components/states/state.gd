class_name State
extends Node


@export var animation_name: String
@export var speed: float = 100.0
@export var velocity_weight: float = 5.0


var parent: CharacterBody2D
var animation_player: AnimationPlayer
var movement_manager: MovementManager


func enter() -> void:
	movement_manager.direction_updated.connect(play_animation)
	play_animation()


func exit() -> void:
	movement_manager.direction_updated.disconnect(play_animation)


func process_input(event: InputEvent) -> State:
	return null


func process_frame(delta: float) -> State:
	return null


func process_physics(delta: float) -> State:
	return null


func get_movement_input() -> Vector2:
	return movement_manager.get_movement_direction()


func get_attack() -> bool:
	return movement_manager.get_attack()


func get_interaction() -> bool:
	return movement_manager.get_interaction()


func play_animation() -> void:
	animation_player.play(animation_name + "_" + movement_manager.direction_string)
