extends CanvasLayer

onready var CanvasModulate = $CanvasModulate
onready var NewGameButton = $PanelContainer/MarginContainer/Rows/VBoxContainer/NewGameButton
onready var ContinueButton = $PanelContainer/MarginContainer/Rows/VBoxContainer/ContinueButton

signal game_start

func _ready():
	pass

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_ContinueButton_pressed():
	set_buttons_disabled()

func _on_NewGameButton_pressed():
	set_buttons_disabled()
	emit_signal("game_start")

func fade_out():
	yield(CanvasModulate.fade_out(0.5), "completed")
	yield(get_tree().create_timer(1.5), "timeout")
	self.queue_free()

func set_buttons_disabled():
	NewGameButton.disabled = true;
	ContinueButton.disabled = true;
