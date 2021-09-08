extends CanvasLayer

onready var CanvasModulate = $CanvasModulate

signal unpause
signal game_start

func _ready():
	pass

func _on_MenuButton_pressed():
	emit_signal("game_start")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_ContinueButton_pressed():
	emit_signal("unpause")

func fade_out():
	yield(CanvasModulate.fade_out(0.5), "completed")
	yield(get_tree().create_timer(1.0), "timeout")
	self.queue_free()
