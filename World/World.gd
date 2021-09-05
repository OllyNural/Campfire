extends Node2D

const GameOverScreen = preload("res://UI/GameOverScreen.tscn")

onready var PlayerContainer = $YSort/PlayerContainer

func _ready():
	PlayerContainer.connect("cold_timeout_game_over", self, "_on_player_loss")

func _on_player_loss():
	print('loss')
	var game_over = GameOverScreen.instance()
	add_child(game_over)
	get_tree().paused = true
