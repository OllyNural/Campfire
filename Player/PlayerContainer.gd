extends Node2D

onready var player = $Player
onready var lantern = $Lantern

signal cold_timeout_game_over

export var ACCELERATION: int = 256
export var MAX_SPEED: int = 32
export var FRICTION: float = 0.2
export var AIR_RESISTANCE: float = 0.02
export var GRAVITY: int = 200
export var JUMP_FORCE: float = 90.0

var invert_velocity = (JUMP_FORCE / 10)

const MAX_JUMP_FORGIVENESS_TIME = 0.08
var jump_forgiveness_time: float = 0.0

var jump_pressed_current: float = 0
var jump_pressed_remember_time: float = 0.2

var is_in_air = false

const FLOOR_NORMAL = Vector2.UP

var lantern_picked_up: bool = false

enum {
	MOVE,
	JUMP,
	STOPPED
}

var state = MOVE
var velocity = Vector2.ZERO
var input_x

func _ready():
	player.connect("lantern_picked_up", self, "_on_lantern_picked_up")
	player.connect("lantern_toggle_state", self, "_on_lantern_toggle_state")
	player.connect("cold_timeout_game_over", self, "_on_cold_timeout_game_over")

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_drop") && lantern_picked_up && player.is_on_floor():
		drop_lantern()
		
	match state:
		MOVE:
			move_state(delta)
		JUMP:
			jump_state(delta)
#		STOPPED:
#			player.move(lantern_picked_up, velocity.x < 0)
	
func jump_state(delta):
	input_x = get_direction().x
	jump_pressed_current -= delta

	var is_moving
	var flip

	if (input_x != 0):
		velocity.x += input_x * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		is_moving = true
		flip = input_x < 0
	else:
		velocity.x = lerp(velocity.x, 0, AIR_RESISTANCE)
		is_moving = false
		flip = velocity.x < 0

	velocity.y += GRAVITY * delta


	if (Input.is_action_just_pressed("ui_up")):
		jump_pressed_current = jump_pressed_remember_time

	if ((player.is_on_floor() && jump_pressed_current > 0) || (jump_forgiveness_time <= MAX_JUMP_FORGIVENESS_TIME) && Input.is_action_just_pressed("ui_up")):
		player.jump("JumpUp", lantern_picked_up, flip, is_moving)
		if (lantern_picked_up):
			lantern.jump("JumpUp", flip)
		velocity.y = -JUMP_FORCE

	if player.is_on_floor():
		if (is_in_air):
			# Start Player land animation
			is_in_air = false
			player.jump("Land", lantern_picked_up, flip, is_moving)
			if (lantern_picked_up):
				lantern.jump("Land", flip)
			state = MOVE

#		jump_forgiveness_time = 0.0
		if (input_x == 0):
			velocity.x = lerp(velocity.x, 0, FRICTION)

	else:
		is_in_air = true

		# Jump is going up
		if (-JUMP_FORCE <= velocity.y && velocity.y < -invert_velocity):
			player.jump("JumpUp", lantern_picked_up, flip, is_moving)
		if (-invert_velocity < velocity.y):
			player.jump("JumpDown", lantern_picked_up, flip, is_moving)
			if (lantern_picked_up):
				lantern.jump("JumpDown", flip)
	
		if (Input.is_action_pressed("ui_up")):
			jump_forgiveness_time = MAX_JUMP_FORGIVENESS_TIME + 1

		jump_forgiveness_time += delta

	velocity = player.move_and_slide(velocity, FLOOR_NORMAL)
	if (lantern_picked_up):
		lantern.move_and_slide(velocity, FLOOR_NORMAL)

func _on_crouch_animation_end():
	state = MOVE
	
func move_state(delta):
	input_x = get_direction().x

	if (input_x != 0):
		velocity.x += input_x * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		player.move(lantern_picked_up, input_x < 0)
		if (lantern_picked_up):
			lantern.move(input_x < 0)
	else:
		player.idle(lantern_picked_up)
		if (lantern_picked_up):
			lantern.idle(velocity.x < 0)
	
	velocity.y += GRAVITY * delta
	
	if (Input.is_action_just_pressed("ui_up")):
		jump_pressed_current = jump_pressed_remember_time

	# Jumping
	if (player.is_on_floor() && jump_pressed_current > 0):
		state = JUMP

	if ((jump_forgiveness_time <= MAX_JUMP_FORGIVENESS_TIME) && Input.is_action_just_pressed("ui_up")):
		state = JUMP

	if player.is_on_floor():
		jump_forgiveness_time = 0.0
		if (input_x == 0):
			velocity.x = lerp(velocity.x, 0, FRICTION)
	else:
		state = JUMP

	velocity = player.move_and_slide(velocity, FLOOR_NORMAL)
	if (lantern_picked_up):
		lantern.move_and_slide(velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	return input_vector

func drop_lantern():
	lantern.handle_dropped()
	lantern_picked_up = false

func _on_lantern_picked_up():
	if (!lantern_picked_up):
		lantern.handle_picked_up(player.global_position)
		lantern_picked_up = true
		if (input_x < 0):
			lantern.move(input_x < 0)
		else:
			lantern.move(velocity.x < 0)
			
func _on_lantern_toggle_state():
	lantern.toggle_state()

func _on_cold_timeout_game_over():
	emit_signal("cold_timeout_game_over")
	lantern.turn_off()
	for i in get_tree().get_nodes_in_group("LightSourceInstance"):
		i.turn_off()

#func game_over():
#	state = STOPPED
