extends KinematicBody2D

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var sprite = $Sprite

onready var lightController = $LightController

var is_lit = true

func _ready():
	print('lantern lightController ready')
	animationTree.active = true
	animationState.travel("FloorAngledOn")
	lightController.set_texture_scale(1)
	lightController.set_light_intensity(0.8)
	lightController.set_flicker_amount(1)
	lightController.set_collision_range(5)
	lightController.fade_in(0.1)

func move(flip: bool):
	animationState.travel("Run")
	flip(flip)

func idle(flip: bool):
	animationState.travel("Idle")
	flip(flip)

func jump(jump_state: String, flip: bool):
	flip(flip)
	match jump_state:
		"JumpUp":
			animationState.travel("JumpOnUp")
		"JumpDown":
			animationState.travel("JumpOnDown")
		"Land":
			animationState.travel("JumpOnLand")

func handle_dropped():
	self.global_position = global_position + Vector2(0, 4)
	animationState.travel("FloorAngledOn")

func handle_picked_up(position: Vector2):
	self.global_position = position - Vector2(0, 4)

func flip(flip: bool):
	if (flip):
		sprite.global_position = global_position - Vector2(5, 0)
	else:
		sprite.global_position = global_position - Vector2(-5, 0)

	sprite.flip_h = flip
	
func toggle_state(time: float = 0.2):
	if (is_lit):
		turn_off(time)
	else:
		turn_on(time)
	is_lit = !is_lit

func turn_on(time: float = 0.2):
	if (!is_lit):
		lightController.fade_in(time)
	is_lit = true

func turn_off(time: float = 0.2):
	if (is_lit):
		lightController.fade_out(time)
	is_lit = false
