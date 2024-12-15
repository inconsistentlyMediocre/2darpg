class_name GoapAgent
extends Node


@export var action_planner: GoapActionPlanner
@export var actor: MovingEntity
@export var goals: Array[GoapGoal]

var current_goal: GoapGoal
var current_plan: Array
var current_plan_step: int = 0




func _process(delta: float) -> void:
	if not Utils.validate([action_planner]):
		return
	
	var goal: GoapGoal = get_best_goal()
	if current_goal == null or goal != current_goal:
		var blackboard: Dictionary = {
			"position": actor.position,
		}
		for state in WorldState.current_world.state:
			blackboard[state] = WorldState.current_world.state[state]
		current_goal = goal
		current_plan = action_planner.get_plan(current_goal, blackboard)
		current_plan_step = 0
	else:
		follow_plan(current_plan, delta)


func init(_actor: Node2D, _goals: Array[GoapGoal]) -> void:
	actor = _actor
	goals = _goals


func get_best_goal() -> GoapGoal:
	var highest_priority: GoapGoal
	
	for goal in goals:
		if goal.is_valid() and (highest_priority == null or goal.priority() > highest_priority.priority()):
			#print(goal)
			highest_priority = goal
	
	return highest_priority


func follow_plan(plan: Array, delta: float) -> void:
	if plan.size() == 0:
		return

	var is_step_complete = plan[current_plan_step].perform(actor, delta)
	if is_step_complete and current_plan_step < plan.size() - 1:
		current_plan_step += 1
