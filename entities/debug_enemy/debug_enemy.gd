class_name Enemy
extends MovingEntity


@export var target: CollisionObject2D


func _ready() -> void:
	super._ready()
	if Utils.validate([target, movement_manager]):
		movement_manager.target = target


func kill() -> void:
	queue_free()
