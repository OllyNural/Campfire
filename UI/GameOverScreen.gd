extends CanvasLayer

func _ready():
	pass

func _on_RestartButton_pressed():
	print('restarting')
	get_tree().paused = false
	get_tree().change_scene("res://World/World.tscn")

func _on_MenuButton_pressed():
	pass # Replace with function body.


func _on_QuitButton_pressed():
	print('quit')
	get_tree().quit()
