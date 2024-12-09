class_name HPManager
extends Node


signal died

@export var max_hp: int = -1
@export var main: bool = false

var hp: int = max_hp:
	set(value):
		hp = value
		if main:
			UIDisplay.hp_container.hp = hp


func _ready() -> void:
	if main:
		UIDisplay.hp_container.max_hp = max_hp
		UIDisplay.hp_container.setup_hp_ui()
		UIDisplay.hp_container.visible = true
	hp = max_hp


func take_damage(attack: Attack) -> void:
	if Utils.validate([attack]):
		print(attack.damage_amount)
		hp -= attack.damage_amount
	if hp <= 0:
		died.emit()
