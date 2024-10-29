extends Node


func validate(objects: Array) -> bool:
	for object in objects:
		if not is_instance_valid(object) or object == null:
			return false
	return true
