class_name GoapAction
extends Node


func is_valid() -> bool:
	return true


func get_cost(blackboard: Dictionary) -> int:
	return 1000


func get_preconditions() -> Dictionary:
	return {}


func get_effects() -> Dictionary:
	return {}


func perform(actor: Node2D, delta: float) -> bool:
	return false
