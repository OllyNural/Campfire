extends KinematicBody2D

var can_move = true setget set_can_move

signal lantern_picked_up
signal lantern_toggle_state
signal cold_timeout_game_over

onready var playerBody = $PlayerBody
onready var itemDetector = $ItemDetector
onready var scaredController = $ScaredController

func _ready():
	playerBody.set_active(true)
	playerBody.animate_idle(false)
	itemDetector.connect("lantern_picked_up", self, "_on_lantern_picked_up")
	itemDetector.connect("lantern_toggle_state", self, "_on_lantern_toggle_state")
	scaredController.connect("cold_timeout_game_over", self, "_on_cold_timeout_game_over")

func move(lantern_picked_up: bool, flip: bool):
	playerBody.animate_move(lantern_picked_up)
	playerBody.flip_h(flip)

func jump(jump_state: String, lantern_picked_up: bool, flip: bool, is_moving: bool):
	playerBody.animate_jump(jump_state, lantern_picked_up, is_moving)
	playerBody.flip_h(flip)

func idle(lantern_picked_up: bool):
	playerBody.animate_idle(lantern_picked_up)

func _on_lantern_picked_up():
	emit_signal("lantern_picked_up")

func _on_lantern_toggle_state():
	emit_signal("lantern_toggle_state")

func _on_cold_timeout_game_over():
	emit_signal("cold_timeout_game_over")

func play(animation: String):
	playerBody.play(animation)

func set_can_move(move: bool):
	can_move = move
	scaredController.set_can_move(move)
	
