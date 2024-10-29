class_name Interactable
extends Area2D


enum InteractableType {
	DIALOGUE,
	SWITCH,
}


@export var action: Callable
@export var type: InteractableType
@export var dialogue_timeline: DialogicTimeline


func interact() -> bool:
	if type == InteractableType.DIALOGUE:
		if Utils.validate([dialogue_timeline]):
			Dialogic.start(dialogue_timeline)
			return true
	return false
