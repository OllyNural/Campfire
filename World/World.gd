extends Node2D

const GameOverScreen = preload("res://UI/GameOverScreen.tscn")

onready var PlayerContainer = $YSort/PlayerContainer
onready var AmbientLighting = $AmbientLighting
onready var Cam = $Camera2D

var game_start

func _ready():
	AmbientLighting.light_scale = AmbientLighting.LIGHT_SCALES.BLACK
	PlayerContainer.connect("cold_timeout_game_over", self, "_on_player_loss")

func _on_player_loss():
	var game_over = GameOverScreen.instance()
	add_child(game_over)
	get_tree().paused = true
