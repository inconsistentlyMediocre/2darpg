extends Node2D


enum ReflectionTypes {
	WATER,
	MIRROR,
}

@export var reflecting_surface: Node2D
@export var reflected_entities: Array[Node2D]
@export var reflection_modulate: Color = Color.WHITE
@export var reflection_mask_color: Color = Color.WHITE
@export var reflection_type: ReflectionTypes

var reflected_graphics: Array[Node2D]
var reflection_material: ShaderMaterial = preload("res://components/reflection/reflection.material")
var opacity_factor: float = 0.05

@onready var reflections: Node2D = $Mask/Reflections
@onready var mask: Sprite2D = $Mask
@onready var sub_viewport: SubViewport = $CanvasLayer/SubViewportContainer/SubViewport
@onready var sub_viewport_container: SubViewportContainer = $CanvasLayer/SubViewportContainer


func _ready() -> void:
	#reflection_material.resource_local_to_scene = true
	#reflection_material.set_shader_parameter("reflectable_color", reflection_mask_color)
	#REFLECTION_MATERIAL.call_deferred("set_shader_parameter", "reflectable_color", reflection_mask_color)
	
	await WorldState.level_set
	WorldState.current_level.child_entered_tree.connect(add_reflected_entities)
	
	var reflecting_mask: Node2D = reflecting_surface.duplicate()
	reflecting_mask.global_position = reflecting_surface.global_position
	reflecting_mask.material = reflection_material.duplicate()
	reflecting_mask.material.set_shader_parameter("reflectable_color", reflection_mask_color)
	#reflecting_mask.material.changed.emit()
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
					if reflection_type == ReflectionTypes.WATER:
						sprite.offset.y *= -1
						sprite.offset.y += 4
						sprite.flip_v = true
					if reflection_type == ReflectionTypes.MIRROR:
						sprite.offset.y += 48
						#sprite.z_index = 1
						sprite.z_index *= -1
						mask.z_index = 1
		reflections.add_child(graphics)
	reflections.modulate = reflection_modulate
	reflections.y_sort_enabled = true
	#reflections.z_index = reflecting_surface.z_index + 1


func _process(delta: float) -> void:
	for i in reflected_graphics.size():
		if reflected_graphics[i]:
			if Utils.validate([reflected_entities[i]]):
				if reflection_type == ReflectionTypes.WATER:
					reflected_graphics[i].global_position = reflected_entities[i].global_position
				elif reflection_type == ReflectionTypes.MIRROR:
					var distance: float = reflected_entities[i].global_position.y - reflecting_surface.global_position.y
					reflected_graphics[i].global_position.x = reflected_entities[i].global_position.x
					reflected_graphics[i].global_position.y = reflecting_surface.global_position.y - reflecting_surface.get_rect().size.y - reflecting_surface.offset.y / 4 - distance
					reflected_graphics[i].visible = reflected_graphics[i].global_position.y < reflected_entities[i].global_position.y - 48
					#reflected_graphics[i].modulate.a = 1.0 - (distance / 4) * opacity_factor
				for j in reflected_graphics[i].get_children().size():
					if reflected_graphics[i].get_child(j) is Sprite2D:
						reflected_graphics[i].get_child(j).texture =  reflected_entities[i].graphics.get_child(j).texture
						reflected_graphics[i].get_child(j).visible =  reflected_entities[i].graphics.get_child(j).visible
						reflected_graphics[i].get_child(j).frame_coords =  reflected_entities[i].graphics.get_child(j).frame_coords
						if reflected_entities[i] is MovingEntity:
							if reflection_type == ReflectionTypes.MIRROR:
								if reflected_entities[i].graphics.get_child(j).frame_coords.y == 0:
									reflected_graphics[i].get_child(j).frame_coords.y = 3
									reflected_graphics[i].get_child(j).flip_h = true
									if reflected_entities[i].animation_player.current_animation.begins_with("walk"):
										match reflected_graphics[i].get_child(j).frame_coords.x:
											1:
												reflected_graphics[i].get_child(j).frame_coords.x = 0
											2:
												reflected_graphics[i].get_child(j).frame_coords.x = 5
											3:
												reflected_graphics[i].get_child(j).frame_coords.x = 4
											4:
												reflected_graphics[i].get_child(j).frame_coords.x = 3
											5:
												reflected_graphics[i].get_child(j).frame_coords.x = 2
											0:
												reflected_graphics[i].get_child(j).frame_coords.x = 1
								elif reflected_entities[i].graphics.get_child(j).frame_coords.y == 3:
									reflected_graphics[i].get_child(j).frame_coords.y = 0
									reflected_graphics[i].get_child(j).flip_h = true
									if reflected_entities[i].animation_player.current_animation.begins_with("walk"):
										match reflected_graphics[i].get_child(j).frame_coords.x:
											1:
												reflected_graphics[i].get_child(j).frame_coords.x = 0
											2:
												reflected_graphics[i].get_child(j).frame_coords.x = 5
											3:
												reflected_graphics[i].get_child(j).frame_coords.x = 4
											4:
												reflected_graphics[i].get_child(j).frame_coords.x = 3
											5:
												reflected_graphics[i].get_child(j).frame_coords.x = 2
											0:
												reflected_graphics[i].get_child(j).frame_coords.x = 1
								else:
									reflected_graphics[i].get_child(j).flip_h = false
			else:
				reflected_graphics[i].queue_free()
				reflected_graphics[i] = null


func add_reflected_entities(node: Node) -> void:
	if node is Node2D:
		reflected_entities.append(node)
		reflected_graphics.append(node.graphics.duplicate())
		for sprite in reflected_graphics[-1].get_children():
			if sprite is Sprite2D:
				if reflection_type == ReflectionTypes.WATER:
					sprite.offset.y *= -1
					sprite.offset.y += 4
					sprite.flip_v = true
				if reflection_type == ReflectionTypes.MIRROR:
					sprite.offset.y += 48
					#sprite.z_index = 1
					sprite.z_index *= -1
					mask.z_index = 1
		reflections.add_child(reflected_graphics[-1])
