@tool
class_name HPContainer
extends GridContainer


enum HeartState {
	FULL,
	HALF,
	EMPTY,
}

const HEART_SCENE: PackedScene = preload("res://ui/hp_container/heart_texture_rect.tscn")


@export var max_hp: int = 0:
	set(value):
		max_hp = value
		hp = clamp(hp, 0, max_hp)
		setup_hp_ui()
@export var hp: int = max_hp:
	set(value):
		hp = value
		hp = clamp(hp, 0, max_hp)
		update_hp_ui()

var hearts: Array[TextureFramesRect]


func _ready() -> void:
	hp = max_hp
	setup_hp_ui()


func setup_hp_ui() -> void:
	for heart in hearts:
		heart.queue_free()
	hearts.clear()
	var hearts_amount: int = ceil(max_hp / 2.0)
	for i in hearts_amount:
		var heart_texture: TextureFramesRect = HEART_SCENE.instantiate()
		add_child(heart_texture)
		hearts.append(heart_texture)
	update_hp_ui()


func update_hp_ui() -> void:
	var max_hearts: int = hearts.size()
	var heart_value: int = ceil(hp / 2.0)
	var is_last_heart_full = hp % 2 == 0
	var last_heart: int = 0
	if not is_last_heart_full:
		last_heart = 1
	
	for i in range(heart_value - last_heart):
		hearts[i].current_frame = HeartState.FULL
	
	if not is_last_heart_full:
		hearts[heart_value - 1].current_frame = HeartState.HALF
	
	for i in range(heart_value, max_hearts):
		hearts[i].current_frame = HeartState.EMPTY
