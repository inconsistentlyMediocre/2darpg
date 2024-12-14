class_name GoapActionPlanner
extends Node


@export var actions: Array[GoapAction]


func set_actions(_actions:Array[GoapAction]) -> void:
	actions = _actions


func get_plan(goal: GoapGoal, blackboard: Dictionary = {}) -> Array[GoapAction]:
	if not Utils.validate([goal]):
		return []
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
	
	if build_plans(root, blackboard.duplicate()):
		var plans: Array[Dictionary] = transform_tree_into_array(root, blackboard)
		return get_cheapest_plan(plans)
	
	return []


func get_cheapest_plan(plans: Array[Dictionary]) -> Array[GoapAction]:
	var best_plan: Dictionary
	for plan in plans:
		if best_plan.is_empty() or plan["cost"] < best_plan["cost"]:
			best_plan = plan
	var result: Array[GoapAction]
	for action in best_plan.actions:
		if action is GoapAction:
			result.append(action)
	return result


func build_plans(step: Dictionary, blackboard: Dictionary) -> bool:
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
		var effects: Dictionary = action.get_effects()
		var desired_state: Dictionary = state.duplicate()
		
		for _state in desired_state:
			print(desired_state[_state])
			print(effects.get(_state))
			if desired_state[_state] == effects.get(_state):
				desired_state.erase(_state)
				should_use_action = true
		
		if should_use_action:
			# adds actions pre-conditions to the desired state
			var preconditions: Dictionary = action.get_preconditions()
			for precondition in preconditions:
				desired_state[precondition] = preconditions[precondition]
			
			var _state: Dictionary = {
				"action": action,
				"state": desired_state,
				"children": []
				}
			
			# if desired state is empty, it means this action
			# can be included in the graph.
			# if it's not empty, _build_plans is called again (recursively) so
			# it can try to find actions to satisfy this current state. In case
			# it can't find anything, this action won't be included in the graph.
			if desired_state.is_empty() or build_plans(_state, blackboard.duplicate()):
				step.children.push_back(_state)
				has_followup = true
	return has_followup


func transform_tree_into_array(plan: Dictionary, blackboard: Dictionary) -> Array[Dictionary]:
	var plans: Array[Dictionary] = []
	
	if plan.children.size() == 0:
		plans.push_back({ "actions": [plan.action], "cost": plan.action.get_cost(blackboard) })
		return plans

	for child in plan.children:
		for child_plan in transform_tree_into_array(child, blackboard):
			if plan.action.has_method("get_cost"):
				child_plan.actions.push_back(plan.action)
				child_plan.cost += plan.action.get_cost(blackboard)
			plans.push_back(child_plan)
	return plans
