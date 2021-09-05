extends Node2D

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var sprite = $Sprite

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
