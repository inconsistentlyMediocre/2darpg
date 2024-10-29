class_name Destructible
extends StaticBody2D


@export var hurtbox: Hurtbox
@export var hp_manager: HPManager
@export var destroyed_texture: Texture2D
@export var interactable_component: Interactable
@export var dialogue_variable_name: String
@onready var sprite: Sprite2D = $Sprite2D


var destroyed: bool = false


func _ready() -> void:
	if Utils.validate([hurtbox, hp_manager]):
		hp_manager.died.connect(destroy)


func destroy() -> void:
	sprite.texture = destroyed_texture
	Dialogic.VAR.set_variable(dialogue_variable_name, true)
