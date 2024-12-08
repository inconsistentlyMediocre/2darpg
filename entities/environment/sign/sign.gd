class_name Sign
extends Destructible


@export var broken_dialogue_timeline: DialogicTimeline


func destroy() -> void:
	super.destroy()
	interactable_component.dialogue_timeline = broken_dialogue_timeline
