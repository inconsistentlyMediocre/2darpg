class_name Hurtbox
extends Area2D


#signal damage_received(attack: Attack)


@export var hp_manager: HPManager
@export var disabled: bool = false

var parent: CharacterBody2D


func _ready() -> void:
	#area_entered.connect(_on_hurtbox_area_entered)
	area_shape_entered.connect(_on_hurtbox_area_shape_entered)


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if disabled:
		return
	if area is Hitbox:
		if area.hitbox_owner != parent:
			#damage_received.emit(area.attack)
			if Utils.validate([hp_manager, area.attack]):
				hp_manager.take_damage(area.attack)


func _on_hurtbox_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if disabled:
		return
	if area is Hitbox:
		if area.hitbox_owner != parent:
			var hitbox: FrameDataHitbox = area.shape_owner_get_owner(area.shape_find_owner(area_shape_index))
			var attack: Attack = hitbox.attack
			if Utils.validate([hp_manager, attack]):
				hp_manager.take_damage(attack)
