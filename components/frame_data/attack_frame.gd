@tool 
class_name AttackFrame
extends Hitbox


@export var btn_add_hitbox: bool = false:
	set(value):
		btn_add_hitbox = false
		add_hitbox()

@export var stream_player: AudioStreamPlayer2D


func _enter_tree() -> void:
	# Deactivate default collision mask and layer
	set_collision_mask_value(1, false)
	set_collision_layer_value(1, false)
	
	# Activate hitbox collision layer
	set_collision_layer_value(5, true)


func add_hitbox() -> void:
	var new_hitbox: FrameDataHitbox = FrameDataHitbox.new()
	new_hitbox.name = "Hitbox_" + str(get_child_count())
	new_hitbox.disabled = true
	add_child(new_hitbox)
	new_hitbox.owner = get_tree().edited_scene_root
