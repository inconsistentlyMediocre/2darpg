class_name Interaction
extends Area2D


var interactables: Array[Interactable]


func _on_area_entered(area: Area2D) -> void:
	if area is Interactable:
		interactables.append(area)


func _on_area_exited(area: Area2D) -> void:
	if area is Interactable:
		if area in interactables:
			interactables.erase(area)


func interact() -> bool:
	if not interactables.is_empty():
		return interactables[0].interact()
	return false
