extends Node2D


const REFLECTION_MATERIAL: ShaderMaterial = preload("res://components/reflection.material")

@export var reflecting_surface: Node2D
@export var reflected_entities: Array[MovingEntity]
@export var reflection_modulate: Color = Color.WHITE

var reflected_graphics: Array[Node2D]

@onready var reflections: Node2D = $Mask/Reflections
@onready var mask: Sprite2D = $Mask
@onready var sub_viewport: SubViewport = $CanvasLayer/SubViewportContainer/SubViewport
@onready var sub_viewport_container: SubViewportContainer = $CanvasLayer/SubViewportContainer


func _ready() -> void:
	var reflecting_mask: Node2D = reflecting_surface.duplicate()
	reflecting_mask.material = REFLECTION_MATERIAL
	sub_viewport.add_child(reflecting_mask)
	for entity in reflected_entities:
		if Utils.validate([entity.graphics]):
			reflected_graphics.append(entity.graphics.duplicate())
		else:
			reflected_graphics.append(null)
	for graphics in reflected_graphics:
		if graphics:
			for sprite in graphics.get_children():
				if sprite is Sprite2D:
					sprite.offset.y *= -1
					sprite.offset.y += 4
					sprite.flip_v = true
		reflections.add_child(graphics)
	reflections.modulate = reflection_modulate


func _process(delta: float) -> void:
	for i in reflected_graphics.size():
		if reflected_graphics[i]:
			if Utils.validate([reflected_entities[i]]):
				reflected_graphics[i].global_position = reflected_entities[i].global_position
				for j in reflected_graphics[i].get_children().size():
					if reflected_graphics[i].get_child(j) is Sprite2D:
						reflected_graphics[i].get_child(j).texture = reflected_entities[i].graphics.get_child(j).texture
						reflected_graphics[i].get_child(j).visible = reflected_entities[i].graphics.get_child(j).visible
						reflected_graphics[i].get_child(j).frame_coords = reflected_entities[i].graphics.get_child(j).frame_coords
			else:
				reflected_graphics[i].queue_free()
				reflected_graphics[i] = null
