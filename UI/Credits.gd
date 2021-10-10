extends CanvasLayer

onready var CanvasModulate = $CanvasModulate

func _ready():
	yield(CanvasModulate.fade_in(2), "completed")

func _on_ItchButton_pressed():
	OS.shell_open("https://olivernural.itch.io/")

func _on_GithubButton_pressed():
	OS.shell_open("https://github.com/ollynural")
