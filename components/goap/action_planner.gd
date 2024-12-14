class_name GoapActionPlanner
extends Node


var actions: Array[GoapAction]


func set_actions(_actions:Array[GoapAction]) -> void:
	actions = _actions


func get_plan(goal: GoapGoal, blackboard: Dictionary = {}) -> Array[GoapAction]:
	var desired_state: Dictionary = goal.get_desired_state().duplicate()
	
	if desired_state.is_empty():
		return []
	
	return find_best_plan(goal, desired_state, blackboard)


func find_best_plan(goal: GoapGoal, desired_state: Dictionary, blackboard: Dictionary) -> Array[GoapAction]:
	var root: Dictionary = {
		"action": goal,
		"state": desired_state,
		"children": [],
	}
	
	if build_plan(root, blackboard.duplicate()):
		var plans: Array[Dictionary] = transform_tree_into_arrays(root, blackboard)
		return get_cheapest_plan(plans)
	
	return []


func get_cheapest_plan(plans: Array[Dictionary]) -> Array[GoapAction]:
	var best_plan: Dictionary
	for plan in plans:
		if best_plan == null or plan.cost < best_plan.cost:
			best_plan = plan
	return best_plan.actions


func build_plan(step: Dictionary, blackboard: Dictionary) -> bool:
	var has_followup: bool = false
	var state: Dictionary = step.state.duplicate()
	
	for _state in step.state:
		if state[_state] == blackboard.get(_state):
			state.erase(_state)
	
	if state.is_empty():
		return true
	
	for action in actions:
		if not action.is_valid():
			continue
		
		var should_use_action: bool = false
	
	return false


func transform_tree_into_arrays(plan: Dictionary, blackboard: Dictionary) -> Array[Dictionary]:
	return []
