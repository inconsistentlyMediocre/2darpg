class_name ActionFollowPlayer
extends GoapAction


@export var parent: MovingEntity
@export var movement_manager: EnemyMovementManager


func get_preconditions() -> Dictionary:
	return {
		"is_player_seen": true
	}


func get_effects() -> Dictionary:
	return {
		"is_player_dead": true,
	}


func perform(actor: Node2D, delta: float) -> bool:
	# Move to random point
	movement_manager.target_position = parent.target.global_position
	# Check if it has line of sight to player
	if movement_manager.target_reached:
		WorldState.current_world.set_state("is_player_dead", true)
		print("ded")
		return true
	return false
