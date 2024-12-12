extends Node2D


@export var reflecting_surface: Node2D

@onready var reflection: Sprite2D = $Reflection
@onready var reflections: Node2D = $Reflections
@onready var mask: PointLight2D = $Mask


func _ready() -> void:
	print(get_tree().get_root().get_path())
	#var viewport: ViewportTexture = ViewportTexture.new()
	#viewport.viewport_path = get_tree().get_root().get_path()
	#reflection.texture = viewport
	
