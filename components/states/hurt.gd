extends State


@export var idle_state: State
@export var move_state: State
@export var attack_state: State

@export var hurtbox: Hurtbox

@export var hitstun_duration: float = 0.4

var timer: Timer
var flash_interval: float = 4.0
var counter: int = 0
var hitstun_over: bool
var attack: Attack
var movement: Vector2 = Vector2.ZERO

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)


func enter() -> void:
	super()
	hurtbox.disabled = true
	timer.timeout.connect(_on_timer_timeout)
	timer.start(hitstun_duration / flash_interval)
	movement = attack.knockback_direction * attack.knockback_force
	#parent.velocity = lerp(parent.velocity, movement * speed, delta * velocity_weight)
	parent.velocity = movement * speed
	get_tree().create_timer(hitstun_duration).timeout.connect(_on_hitstun_over)


func exit() -> void:
	super()
	hitstun_over = false
	hurtbox.disabled = false
	movement = Vector2.ZERO
	timer.timeout.disconnect(_on_timer_timeout)
	timer.stop()


func process_physics(delta: float) -> State:
	#var movement: Vector2 = get_movement_input()
	parent.velocity = lerp(parent.velocity, Vector2.ZERO, delta * velocity_weight)
	parent.move_and_slide()
	if hitstun_over:
		return idle_state
	return null


func _on_hitstun_over() -> void:
	hitstun_over = true


func _on_timer_timeout() -> void:
	parent.visible = !parent.visible
