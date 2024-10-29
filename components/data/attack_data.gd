class_name Attack
extends Resource


enum DamageType {
	NORMAL,
	FIRE,
	ELECTRIC,
}


@export var damage_amount: int = 1
@export var damage_type: DamageType = DamageType.NORMAL
