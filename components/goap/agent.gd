class_name GoapAgent
extends Node



var goals: Array[GoapGoal]
var current_goal: GoapGoal
var current_plan: Array
var current_plan_step: int = 0

var actor: Node2D


func _process(delta: float) -> void:
	pass


func get_best_goal() -> GoapGoal:
	var highest_priority: GoapGoal
	
	for goal in goals:
		if goal.is_valid() and (highest_priority == null or goal.priority() > highest_priority.priority()):
			highest_priority = goal
	
	return highest_priority


func _follow_plan(plan: Array, delta: float) -> void:
	if plan.size() == 0:
		return

	var is_step_complete = plan[current_plan_step].perform(actor, delta)
	if is_step_complete and current_plan_step < plan.size() - 1:
		current_plan_step += 1
