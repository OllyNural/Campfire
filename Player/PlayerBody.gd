extends Node2D

onready var player_torso = $PlayerTorso
onready var player_hand = $PlayerArm

func set_active(state: bool) -> void:
	player_torso.set_active(state)
	player_hand.set_active(state)
	
func animate_idle(lantern_picked_up: bool) -> void:
	player_torso.animate_idle()
	player_hand.animate_idle(lantern_picked_up)

func animate_move(lantern_picked_up: bool) -> void:
	player_torso.animate_move()
	player_hand.animate_move(lantern_picked_up)

func animate_jump(jump_state: String, lantern_picked_up: bool, is_moving: bool):
	player_torso.animate_jump(jump_state, is_moving)
	player_hand.animate_jump(jump_state, lantern_picked_up, is_moving)

func animate_sitting():
	print('animate_sitting')
	player_torso.animate_sitting()
	player_hand.animate_sitting()

func flip_h(flip: bool):
	player_torso.flip_h(flip)
	player_hand.flip_h(flip)

func play(animation: String):
	player_torso.play(animation)
	player_hand.play(animation)
