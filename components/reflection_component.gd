extends Node2D


@export var reflecting_surface: Node2D
@export var player: Player

@onready var reflections: Node2D = $Mask/Reflections
@onready var mask: Sprite2D = $Mask
@onready var sub_viewport: SubViewport = $CanvasLayer/SubViewportContainer/SubViewport
@onready var sub_viewport_container: SubViewportContainer = $CanvasLayer/SubViewportContainer


func _ready() -> void:
	pass#sub_viewport.add_child(reflecting_surface.duplicate())
