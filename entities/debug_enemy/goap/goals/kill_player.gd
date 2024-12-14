class_name GoalKillPlayer
extends GoapGoal


func is_valid() -> bool:
	return WorldState.current_world.get_elements("Player").size() > 0


func priority() -> int:
	return 10


func get_desired_state() -> Dictionary:
	return {
		"is_player_dead": true,
	}
