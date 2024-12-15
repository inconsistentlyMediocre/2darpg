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
var has_line_of_sight: bool = false
var last_known_position: Vector2 = Vector2.ZERO
var target_position: Vector2 = Vector2.ZERO
var target_reached: bool = false
var direction: Vector2 = Vector2.ZERO

var nav_agent_ready: bool = false


func _ready() -> void:
	ray_directions.resize(rays_amount)
	interest.resize(rays_amount)
	danger.resize(rays_amount)
	last_known_position = parent.global_position
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
			desired_direction = parent.global_position.direction_to(target_position)
		if not target_reached:
			for i in rays_amount:
				var interest_value: float = ray_directions[i].dot(desired_direction.normalized())
				interest_value = remap(interest_value, -1.0, 1.0, 0.0, 1.0)
				interest[i] = interest_value#max(0.0, interest_value)


func set_danger() -> void:
	#var space_state: PhysicsDirectSpaceState2D = get_viewport().world_2d.direct_space_state
	for i in rays_amount:
		if Utils.validate([parent, target]):
			#var query: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(parent.global_position,
			#parent.global_position + ray_directions[i] * look_ahead)
			#query.collide_with_areas = true
			#query.exclude = [parent.get_rid(), target.get_rid()]
			var result: Dictionary = get_collisions(ray_directions[i])#space_state.intersect_ray(query)
			if result.is_empty():
				danger[i] = 0.0
				#danger[i] = move_toward(danger[i], 0.0, interest[i])
				#if interest[i] > 0.5:
				#	danger[i] = 0.0#min(0.0, danger[i] - interest[i])
			else:
				#print(parent.global_position.distance_to(result["position"]))
				var distance: float = parent.global_position.distance_to(result["position"])
				var score: float = remap(distance, 0.0, look_ahead, 1.0, 0.0)
				danger[i] = score
				interest[i] -= score


func get_collisions(direction: Vector2, exclude_target: bool = true) -> Dictionary:
	var space_state: PhysicsDirectSpaceState2D = get_viewport().world_2d.direct_space_state
	var query: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(parent.global_position,
	parent.global_position + direction * look_ahead * 10)
	query.collide_with_areas = true
	if exclude_target:
		query.exclude = [parent.get_rid(), target.get_rid()]
	else:
		query.exclude = [parent.get_rid()]
	var result: Dictionary = space_state.intersect_ray(query)
	return result


func get_movement_direction() -> Vector2:
	if Utils.validate([target, parent]):
		if Utils.validate([nav_agent]):
			# Update the navigation agent's target position to the target node's position
			nav_agent.target_position = target.global_position
		
		var result: Dictionary = get_collisions(parent.global_position.direction_to(target.global_position)*look_ahead, false)
		
		if not result.is_empty():
			has_line_of_sight = result["collider"] == target
			if has_line_of_sight:
				last_known_position = target.global_position
				#target_position = target.global_position
			else:
				pass#target_position = last_known_position
		else:
			has_line_of_sight = false
		
		set_interest()
		set_danger()
		
		for i in rays_amount:
			debug_draw.interest[i] = interest[i]
			debug_draw.danger[i] = danger[i]
				
		if not target_reached:
			direction = Vector2.ZERO
			for i in rays_amount:
				direction += ray_directions[i] * interest[i]
		
		if parent.global_position.distance_to(target_position) < look_ahead / 2.0:
			# We reached the player
			if target_position == target.global_position:
				direction = Vector2.ZERO
			# We reached the last known player position
			else:
				direction = Vector2.ZERO
			target_reached = true
		else:
			if has_line_of_sight:
				target_reached = false
			debug_draw.dir = direction
		if target_reached:
			direction = direction.move_toward(Vector2.ZERO, 0.5)
			if direction.distance_to(Vector2.ZERO) < 0.3:
				pass#direction = Vector2.ZERO
		direction = direction.normalized()
		set_direction_string(direction)
		return direction
	return Vector2.ZERO


func get_attack() -> bool:
	return false
	if Utils.validate([target, parent]):
		return parent.global_position.distance_to(target.global_position) < look_ahead / 2.0
	return false
