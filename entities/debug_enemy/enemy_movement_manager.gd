class_name EnemyMovementManager
extends MovementManager


@export var parent: CharacterBody2D
@export var nav_agent: NavigationAgent2D
@export var look_ahead: float = 24.0
@export var rays_amount: int = 8

var target: Node2D
var ray_directions: Array[Vector2] = []
var interest: Array[float] = []
var danger: Array[float] = []
var nav_agent_ready: bool = false


func _ready() -> void:
	ray_directions.resize(rays_amount)
	interest.resize(rays_amount)
	danger.resize(rays_amount)
	for i in rays_amount:
		var angle: float = i * 2 * PI / rays_amount
		ray_directions[i] = Vector2.RIGHT.rotated(angle)
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
			interest[i] = max(0, interest_value)


func set_danger() -> void:
	var space_state: PhysicsDirectSpaceState2D = get_viewport().world_2d.direct_space_state
	for i in rays_amount:
		
		if Utils.validate([parent, target]):
			var query: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(parent.global_position,
			parent.global_position + ray_directions[i] * look_ahead)
			query.exclude = [parent.get_rid(), target.get_rid()]
			var result: Dictionary = space_state.intersect_ray(query)
			if result.is_empty():
				danger[i] = 0.0
			else:
				danger[i] = 1.0


func get_movement_direction() -> Vector2:
	if Utils.validate([target, parent]):
		if Utils.validate([nav_agent]):
			nav_agent.target_position = target.global_position
		#var direction: Vector2 = parent.global_position.direction_to(target.global_position)
		#set_direction_string(direction)
		set_interest()
		set_danger()
		#var added_interest: float = 20.0
		for i in rays_amount:
			if danger[i] > 0.0:
				#if i > rays_amount / 2:
					#interest[i - rays_amount / 2 - 1] = added_interest
				#else:
					#interest[i + rays_amount / 2 - 1] = added_interest
				interest[i] = 0.0
		var direction: Vector2 = Vector2.ZERO
		for i in rays_amount:
			direction += ray_directions[i] * interest[i]
		direction = direction.normalized()
		if parent.global_position.distance_to(target.global_position) < 24.0:
			direction = Vector2.ZERO
		set_direction_string(direction)
		return direction
	return Vector2.ZERO


func get_attack() -> bool:
	if Utils.validate([target, parent]):
		return parent.global_position.distance_to(target.global_position) < 24.0
	return false
