extends Node2D

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var sprite = $Sprite

onready var snowStep1 = $SnowStep1
onready var snowStep2 = $SnowStep2
onready var snowLand = $SnowLand

func set_active(state: bool) -> void:
	animationTree.active = state

func animate_idle() -> void:
	animationState.travel("Idle")

func animate_move() -> void:
	animationState.travel("Run")

func animate_jump(jump_state, is_moving) -> void:
	match jump_state:
		"JumpUp":
			if (is_moving): animationState.travel("JumpMoveUp")
			else: animationState.travel("JumpStillUp")
		"JumpDown":
			if (is_moving): animationState.travel("JumpMoveDown")
			else: animationState.travel("JumpStillDown")
		"Land":
			if (is_moving): animationState.travel("JumpMoveLand")
			else: animationState.travel("JumpStillLand")

func flip_h(flip: bool):
	sprite.flip_h = flip

func play(animation: String):
	animationPlayer.play(animation)

func on_snow_step_1():
	snowStep1.play()

func on_snow_step_2():
	snowStep2.play()

func on_snow_land():
	snowLand.play()
