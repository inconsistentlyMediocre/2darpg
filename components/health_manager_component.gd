class_name HPManager
extends Node


signal died

@export var max_hp: int = -1
@export var main: bool = false

var attack_object: Attack = null

var hp: int = max_hp:
	set(value):
		hp = value
		if main:
			UIDisplay.hp_container.hp = hp

var is_hit: bool = false


func _ready() -> void:
	if main:
		UIDisplay.hp_container.max_hp = max_hp
		UIDisplay.hp_container.setup_hp_ui()
		UIDisplay.hp_container.visible = true
	hp = max_hp


func take_damage(attack: Attack) -> void:
	if Utils.validate([attack]):
		hp -= attack.damage_amount
		attack_object = attack
	if hp <= 0:
		died.emit()


func get_hit() -> Attack:
	var result: Attack = attack_object
	attack_object = null
	if result:
		return result
	return null
