class_name ActionLookForPlayer
extends GoapAction


@export var parent: MovingEntity
@export var movement_manager: EnemyMovementManager

var point_selected: bool = false


func is_valid() -> bool:
	return WorldState.current_world.get_elements("Player").size() > 0


func get_cost(blackboard: Dictionary) -> int:
	return 1


func get_preconditions() -> Dictionary:
	return {}


func get_effects() -> Dictionary:
	return {
		"is_player_seen": true,
	}


func perform(actor: Node2D, delta: float) -> bool:
	print("searching")
	# Move to random point
	if not point_selected:
		movement_manager.target_position = Vector2(randf_range(0.0, 320.0), randf_range(0.0, 320.0))
		point_selected = true
	# Check if it has line of sight to player
	if movement_manager.has_line_of_sight:
		WorldState.current_world.set_state("is_player_seen", true)
		print("spotted")
		point_selected = false
		return true
	else:
		if movement_manager.target_reached:
			print("selecttaw")
			movement_manager.target_position = Vector2(randf_range(0.0, 320.0), randf_range(0.0, 320.0))
			point_selected = false
	return false
