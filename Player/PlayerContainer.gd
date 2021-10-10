extends Node2D

onready var player = $Player
onready var lantern = $Lantern

signal cold_timeout_game_over
signal recent_lightsource_checkpoint

export var ACCELERATION: int = 256
export var MAX_SPEED: int = 32
export var FRICTION: float = 0.2
export var AIR_RESISTANCE: float = 0.02
export var GRAVITY: int = 200
export var JUMP_FORCE: float = 105.0

var can_move = true setget set_can_move

var invert_velocity = (JUMP_FORCE / 10)

const MAX_JUMP_FORGIVENESS_TIME = 0.01
var jump_forgiveness_time: float = 0.0

var jump_pressed_current: float = 0
var jump_pressed_remember_time: float = 0.2

var is_in_air = false

const FLOOR_NORMAL = Vector2.UP

var lantern_picked_up: bool = false

enum {
	MOVE,
	JUMP,
	STOPPED,
	SITTING
}

var state = MOVE
var velocity = Vector2.ZERO
var input_x
var prev_input = 0

var move_right: float = 0;
var move_left: float = 0;
var move_jump: bool = false;
var action_ui_drop: bool = false;

func _ready():
	player.connect("lantern_picked_up", self, "_on_lantern_picked_up")
	player.connect("lantern_toggle_state", self, "_on_lantern_toggle_state")
	player.connect("cold_timeout_game_over", self, "_on_cold_timeout_game_over")
	player.connect("recent_lightsource_checkpoint", self, "_on_recent_lightsource_checkpoint")

func _physics_process(delta):
	if can_move:
		handle_inputs();

	if action_ui_drop && lantern_picked_up && player.is_on_floor():
		drop_lantern()
		
	match state:
		MOVE:
			move_state(delta)
		JUMP:
			jump_state(delta)
		SITTING:
			pass

func set_state_sitting():
	state = SITTING

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
		flip = prev_input < 0

#	print('is moving', is_moving)
	velocity.y += GRAVITY * delta

	if (move_jump):
		jump_pressed_current = jump_pressed_remember_time

	if ((player.is_on_floor() && jump_pressed_current > 0) || (jump_forgiveness_time <= MAX_JUMP_FORGIVENESS_TIME) && move_jump):
		player.jump("JumpUp", lantern_picked_up, flip, is_moving)
		if (lantern_picked_up):
			lantern.jump("JumpUp", flip)
		velocity.y = -JUMP_FORCE
	
	velocity = player.move_and_slide_with_snap(velocity, Vector2.UP, FLOOR_NORMAL)
	if (lantern_picked_up):
		lantern.position = player.position + Vector2(0, -4)

	if player.is_on_floor():
		if (is_in_air):
			# Start Player land animation
			is_in_air = false
			player.jump("Land", lantern_picked_up, flip, is_moving)
			if (lantern_picked_up):
				lantern.jump("Land", flip)
			state = MOVE

		if (input_x == 0):
			velocity.x = lerp(prev_input, 0, FRICTION)

	else:
		is_in_air = true

		# Jump is going up
		if (-JUMP_FORCE <= velocity.y && velocity.y < -invert_velocity):
			player.jump("JumpUp", lantern_picked_up, flip, is_moving)
			if (lantern_picked_up):
				lantern.jump("JumpUp", flip)
		if (-invert_velocity < velocity.y):
			player.jump("JumpDown", lantern_picked_up, flip, is_moving)
			if (lantern_picked_up):
				lantern.jump("JumpDown", flip)
	
		if (move_jump):
			jump_forgiveness_time = MAX_JUMP_FORGIVENESS_TIME + 1
	
	if (input_x):
		prev_input = input_x

func move_state(delta):
	input_x = get_direction().x
	
	var flip

	if (input_x != 0):
		velocity.x += input_x * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		flip = input_x < 0
		player.move(lantern_picked_up, flip)
		if (lantern_picked_up):
			lantern.move(flip)
	else:
		flip = prev_input < 0
		player.idle(lantern_picked_up)
		if (lantern_picked_up):
			lantern.idle(flip)
	
	if (move_jump):
		jump_pressed_current = jump_pressed_remember_time

	# Jumping
	if (player.is_on_floor() && jump_pressed_current > 0):
		jump_forgiveness_time = 0.0
		state = JUMP

	if ((jump_forgiveness_time <= MAX_JUMP_FORGIVENESS_TIME) && jump_pressed_current > 0):
		jump_forgiveness_time = 0.0
		state = JUMP

	if player.is_on_floor():
		jump_forgiveness_time = 0.0
		if (input_x == 0):
			velocity.x = lerp(velocity.x, 0, FRICTION)
	else:
		state = JUMP

	velocity.y += GRAVITY * delta

	velocity = player.move_and_slide_with_snap(velocity, Vector2.UP, FLOOR_NORMAL)
	if (lantern_picked_up):
		lantern.position = player.position + Vector2(0, -4)

	if (input_x):
		prev_input = input_x
	
	jump_forgiveness_time += delta

func handle_inputs():
	set_move_right(Input.get_action_strength("ui_right"))
	set_move_left(Input.get_action_strength("ui_left"))
	set_move_jump(Input.is_action_just_pressed("ui_up"))
	player.set_ui_toggle(Input.is_action_just_pressed("ui_toggle"))
#	set_action_ui_drop(Input.is_action_just_pressed("ui_drop"))

func set_move_right(value: float):
	move_right = value;

func set_move_left(value: float):
	move_left = value;

func set_move_jump(value: bool):
	move_jump = value;

func set_action_ui_drop(value: bool):
	action_ui_drop = value;

func toggle_lantern():
	player.toggle_lantern()

func get_direction() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = move_right - move_left
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

func _on_recent_lightsource_checkpoint(checkpoint_position: Vector2):
	emit_signal("recent_lightsource_checkpoint", checkpoint_position)

func startOpeningCutscene():
	can_move = true

func reset_player(move_position: Vector2):
	player.global_position = move_position
	player.reset_cold()
	_on_lantern_picked_up()

func set_can_move(move: bool):
	can_move = move
	player.set_can_move(move)
	lantern.set_can_move(move)

func set_sitting():
	print('set_sitting')
	player.set_animate_sitting()

