extends Node2D

var ray_directions: Array[Vector2] = []
var rays_amount: int = 12
var interest: Array[float] = []
var danger: Array[float] = []


func _ready() -> void:
	ray_directions.resize(rays_amount)
	interest.resize(rays_amount)
	danger.resize(rays_amount)


func _draw() -> void:
	if ray_directions.is_empty():
		return
	if interest.is_empty() or danger.is_empty():
		return
	for i in rays_amount:
		var angle: float = i * 2 * PI / rays_amount
		ray_directions[i] = Vector2.RIGHT.rotated(angle)
		var color: Color = Color(danger[i], interest[i], 0.0)
		#color.v = 1.0
		draw_line(position, ray_directions[i] * 16.0, color, 2.0)
	#print("a")


func _process(delta: float) -> void:
	queue_redraw()
