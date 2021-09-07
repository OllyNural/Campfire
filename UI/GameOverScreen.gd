extends CanvasLayer

onready var CanvasModulate = $CanvasModulate

signal game_start

func _ready():
	pass

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_ContinueButton_pressed():
	pass # Replace with function body.

func _on_NewGameButton_pressed():
	emit_signal("game_start")
