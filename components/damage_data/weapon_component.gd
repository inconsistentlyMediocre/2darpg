class_name Weapon
extends Node


enum WeaponType {
	SWORD,
	SPEAR,
	BOW,
}

@export var type: WeaponType = WeaponType.SWORD
@export var attack: Attack
@export var spritesheet: Texture2D
@export var weapon_sprite: Sprite2D
@export var hitbox_component: Hitbox


func _ready() -> void:
	# Set the hframe and vframe numbers depending on the weapon type
	# FIXME: Handle this somewhere else, in a more granular way maybe
	match type:
		WeaponType.SWORD:
			weapon_sprite.hframes = 5
			weapon_sprite.vframes = 4
		_:
			weapon_sprite.hframes = 5
			weapon_sprite.vframes = 4
	# Assign corresponding weapon sprite
	weapon_sprite.texture = spritesheet
