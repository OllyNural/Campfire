extends Sprite

onready var Tween = $Tween

var is_entered: bool = false

func _ready():
	pass

func _on_Area2D_area_entered(area):
	if (!is_entered):
		Tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.25, Tween.TRANS_LINEAR)
		Tween.start()
	is_entered = true


func _on_Area2D_area_exited(area):
	if (is_entered):
		Tween.interpolate_property(self, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.25, Tween.TRANS_LINEAR)
		Tween.start()
	is_entered = false
