extends Node2D

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var sprite = $Sprite

func set_active(state: bool) -> void:
	animationTree.active = state

func animate_idle(lantern_picked_up: bool) -> void:
	if (lantern_picked_up):
		animationState.travel("IdleLantern")
	else:
		animationState.travel("Idle")

func animate_move(lantern_picked_up: bool) -> void:
	if (lantern_picked_up):
		animationState.travel("RunLantern")
	else:
		animationState.travel("Run")

func animate_jump(jump_state, lantern_picked_up, is_moving) -> void:
	match jump_state:
		"JumpUp":
			if (is_moving): 
				if (lantern_picked_up): animationState.travel("JumpMoveUpLantern")
				else: animationState.travel("JumpMoveUp")
			else: 
				if (lantern_picked_up): animationState.travel("JumpStillUpLantern")
				else: animationState.travel("JumpStillUp")
		"JumpDown":
			if (is_moving): 
				if (lantern_picked_up): animationState.travel("JumpMoveDownLantern")
				else: animationState.travel("JumpMoveDown")
			else: 
				if (lantern_picked_up): animationState.travel("JumpStillDownLantern")
				else: animationState.travel("JumpStillDown")
		"Land":
			if (is_moving): 
				if (lantern_picked_up): animationState.travel("JumpMoveLandLantern")
				else: animationState.travel("JumpMoveLand")
			else: 
				if (lantern_picked_up): animationState.travel("JumpStillLandLantern")
				else: animationState.travel("JumpStillLand")

func flip_h(flip: bool):
	sprite.flip_h = flip

func play(animation: String):
	animationPlayer.play(animation)
