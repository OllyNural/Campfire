extends Node2D

const GameOverScreen = preload("res://UI/GameOverScreen.tscn")
const PausedScreen = preload("res://UI/PausedScreen.tscn")

onready var PlayerContainer = $YSort/PlayerContainer
onready var AmbientLighting = $AmbientLighting
onready var remoteTransform2D = $Camera2D/RemoteTransform2D

var pausedScreen
var gameOver

var isPaused
var isGameOver = false
var recent_lightsource_checkpoint

func _ready():
	get_tree().paused = false
	AmbientLighting.light_scale = AmbientLighting.LIGHT_SCALES.BLACK
	PlayerContainer.connect("cold_timeout_game_over", self, "_on_player_loss")
	PlayerContainer.connect("recent_lightsource_checkpoint", self, "_on_recent_lightsource_checkpoint")
	PlayerContainer.startOpeningCutscene()

func _process(delta):
	if (!isGameOver):
		pause_handler()

# Game Paused
func pause_handler():
	if Input.is_action_just_pressed("ui_pause"):
		if (isPaused):
			_unpause_handler()
		else:
			pausedScreen = PausedScreen.instance()
			add_child(pausedScreen)
			get_tree().paused = true
			pausedScreen.connect("unpause", self, "_unpause_handler")
			pausedScreen.connect("game_start", self, "_on_game_start", [pausedScreen])
			isPaused = true

func _unpause_handler():
	pausedScreen.queue_free()
	get_tree().paused = false
	isPaused = false

# Game Over
func _on_player_loss():
	isGameOver = true
	gameOver = GameOverScreen.instance()
	add_child(gameOver)
	get_tree().paused = true
	gameOver.connect("game_start", self, "_on_game_start", [gameOver])
	gameOver.connect("world_start", self, "_on_world_start", [gameOver])
	gameOver.connect("continue_from_recent_checkpoint", self, "_on_continue_from_recent_checkpoint", [gameOver])

func _on_game_start(menuNode: Node):
	for i in get_tree().get_nodes_in_group("LightSourceInstance"):
		i.turn_off(1)

	menuNode.fade_out()
	yield(get_tree().create_timer(1.5), "timeout")
	get_tree().change_scene("res://Levels/GameStart.tscn")

func _on_world_start(menuNode: Node):
	for i in get_tree().get_nodes_in_group("LightSourceInstance"):
		i.turn_off(1)

	menuNode.fade_out()
	yield(get_tree().create_timer(1.5), "timeout")
	get_tree().change_scene("res://World/World.tscn")

func _on_continue_from_recent_checkpoint(menuNode: Node):
	yield(menuNode.fade_out(), "completed")
	PlayerContainer.reset_player(recent_lightsource_checkpoint)
#	yield(get_tree().create_timer(1.5), "timeout")
	get_tree().paused = false 
#	yield(menuNode.fade_in(), "completed"
	isGameOver = false

func _on_recent_lightsource_checkpoint(checkpoint_position: Vector2):
	recent_lightsource_checkpoint = checkpoint_position
