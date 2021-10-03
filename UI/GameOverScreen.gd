extends CanvasLayer

onready var CanvasModulate = $CanvasModulate

signal game_start
signal world_start
signal continue_from_recent_checkpoint

func _ready():
	pass

func fade_out():
	yield(CanvasModulate.fade_out(0.5), "completed")
	yield(get_tree().create_timer(1.0), "timeout")
	self.queue_free()

func fade_in():
	yield(CanvasModulate.fade_in(0.5), "completed")
	yield(get_tree().create_timer(1.0), "timeout")
	self.queue_free()

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_MenuButton_pressed():
	emit_signal("game_start")

func _on_ContinueButton_pressed():
	emit_signal('continue_from_recent_checkpoint')
