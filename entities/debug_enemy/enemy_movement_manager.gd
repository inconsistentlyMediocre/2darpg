class_name EnemyMovementManager
extends MovementManager


@export var parent: CharacterBody2D
@export var nav_agent: NavigationAgent2D
@export var look_ahead: float = 24.0
@export var rays_amount: int = 8
@export var debug_draw: Node2D

var target: Node2D
var ray_directions: Array[Vector2] = []
var interest: Array[float] = []
var danger: Array[float] = []
var nav_agent_ready: bool = false


func _ready() -> void:
	ray_directions.resize(rays_amount)
	interest.resize(rays_amount)
	danger.resize(rays_amount)
	if nav_agent:
		nav_agent.target_desired_distance = look_ahead
	for i in rays_amount:
		var angle: float = i * 2 * PI / rays_amount
		ray_directions[i] = Vector2.RIGHT.rotated(angle)
	debug_draw.ray_directions = ray_directions
	set_deferred("nav_agent_ready", true)


func set_interest() -> void:
	if Utils.validate([target, parent]):
		var desired_direction: Vector2
		if nav_agent:
			if nav_agent_ready:
				desired_direction = parent.global_position.direction_to(nav_agent.get_next_path_position())
		else:
			desired_direction = parent.global_position.direction_to(target.global_position)
		for i in rays_amount:
			var interest_value: float = ray_directions[i].dot(desired_direction.normalized())
			interest[i] = max(0.5, interest_value)
			if i >= rays_amount / 2:
				if interest[i - rays_amount / 2] < 0.5:
					interest[i - rays_amount / 2] = 0.75
			else:
				if interest[i + rays_amount / 2] < 0.5:
					interest[i + rays_amount / 2] = 0.75
			#if danger[i] > 0.0:
				#interest[i] = 0.5
			#else:
				#interest[i] = max(0.5, interest_value)
			#interest[i] = interest_value


func set_danger() -> void:
	var space_state: PhysicsDirectSpaceState2D = get_viewport().world_2d.direct_space_state
	for i in rays_amount:
		if Utils.validate([parent, target]):
			var query: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(parent.global_position,
			parent.global_position + ray_directions[i] * look_ahead)
			query.collide_with_areas = true
			query.exclude = [parent.get_rid(), target.get_rid()]
			#query.exclude = [parent.get_rid()]
			var result: Dictionary = space_state.intersect_ray(query)
			if result.is_empty():
				danger[i] = 0.0
				#if interest[i] > 0.5:
				#	danger[i] = 0.0#min(0.0, danger[i] - interest[i])
			else:
				danger[i] = 1.0#max(wdanger[i], 1.0)#1.0


func get_movement_direction() -> Vector2:
	if Utils.validate([target, parent]):
		if Utils.validate([nav_agent]):
			# Set the navigation agent's target position to the target node's position
			nav_agent.target_position = target.global_position
		
		#set_danger()
		set_interest()
		set_danger()
		var added_interest: float = 0.5
		for i in rays_amount:
			if danger[i] > 0.0:
				pass
				#interest[i] = 0.0
				#interest[-i] = 1.0
				if i >= rays_amount / 2:
					if danger[i - rays_amount / 2] == 0.0:
						interest[i - rays_amount / 2] = added_interest
				else:
					if danger[i + rays_amount / 2] == 0.0:
						interest[i + rays_amount / 2] = added_interest
				if interest[i] > 0.0 and danger[i] > 0.0:
					interest[i] = 0.0
			debug_draw.interest[i] = interest[i]
			debug_draw.danger[i] = danger[i]
				#interest[i] = 0.0
				#interest[i-1] = 1.0
				#pass
				
		var direction: Vector2 = Vector2.ZERO
		for i in rays_amount:
			pass
			direction += ray_directions[i] * interest[i]
			direction -= ray_directions[i] * danger[i]
		direction = direction.normalized()
		if parent.global_position.distance_to(target.global_position) < look_ahead / 2.0:
			pass#direction = Vector2.ZERO
		set_direction_string(direction)
		return direction
	return Vector2.ZERO


func get_attack() -> bool:
	return false
	if Utils.validate([target, parent]):
		return parent.global_position.distance_to(target.global_position) < look_ahead / 2.0
	return false
