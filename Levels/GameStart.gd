extends Node2D

const GameStartScreen = preload("res://UI/GameStartScreen.tscn")

onready var AmbientLighting = $AmbientLighting

var game_start

func _ready():
	get_tree().paused = false
	add_start_screen()

func add_start_screen():
	game_start = GameStartScreen.instance()
	game_start.connect("game_start", self, "_on_game_start")
	add_child(game_start)

func _on_game_start():
	for i in get_tree().get_nodes_in_group("LightSourceInstance"):
		i.turn_off(1)
	
	game_start.fade_out()
	yield(get_tree().create_timer(1.5), "timeout")
	get_tree().change_scene("res://World/World.tscn")
