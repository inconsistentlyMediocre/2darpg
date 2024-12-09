class_name Attack
extends Resource


enum DamageType {
	NORMAL,
	FIRE,
	ELECTRIC,
}


@export var damage_amount: int = 1
@export var damage_type: DamageType = DamageType.NORMAL
@export var knockback_force: float = 1.0
@export var knockback_direction: Vector2 = Vector2.ZERO
@export var hitstop_value: float = 0.0
