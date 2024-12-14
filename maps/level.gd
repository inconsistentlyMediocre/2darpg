class_name Level
extends Node2D


@export var level_name: String

var state: Dictionary = {}


func get_state(state_name: String, default = null) -> Variant:
	return state.get(state_name, default)


func set_state(state_name: String, value: Variant) -> void:
	state[state_name] = value


func clear_state() -> void:
	state.clear()


func get_elements(group_name: String) -> Array:
	return get_tree().get_nodes_in_group(group_name)


func get_closest_element(group_name: String, reference: Node2D) -> Node2D:
	var elements: Array = get_elements(group_name)
	var closest_element: Node2D
	var closest_distance = 10000000
	
	for element in elements:
		var distance: float = reference.position.distance_to(element.position)
		if  distance < closest_distance:
			closest_distance = distance
			closest_element = element

	return closest_element
