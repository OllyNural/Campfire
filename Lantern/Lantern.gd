extends KinematicBody2D

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var sprite = $Sprite

onready var lightController = $LightController

var is_lit = true

func _ready():
	animationTree.active = true
	animationState.travel("FloorAngledOn")
	lightController.play("Default")

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
	
func toggle_state():
	if (is_lit):
		lightController.play("FadeOut")
	else:
		lightController.play("FadeIn")
	is_lit = !is_lit

func fade_in():
	is_lit = true
	lightController.play("FadeIn")

func fade_out():
	is_lit = false
	lightController.play("FadeOut")
