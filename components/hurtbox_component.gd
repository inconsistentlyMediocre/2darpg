class_name Hurtbox
extends Area2D


#signal damage_received(attack: Attack)


@export var hp_manager: HPManager

var parent: CharacterBody2D


func _ready() -> void:
	area_entered.connect(_on_hurtbox_area_entered)


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		if area.hitbox_owner != parent:
			#damage_received.emit(area.attack)
			if Utils.validate([hp_manager]):
				hp_manager.take_damage(area.attack)
