extends Node2D

var isLanternInRange: bool = false

signal lantern_picked_up
signal lantern_toggle_state

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_pickup") && isLanternInRange:
		emit_signal("lantern_picked_up")
	
	if Input.is_action_just_pressed("ui_toggle") && isLanternInRange:
		emit_signal("lantern_toggle_state")

func _on_PickupAreaBox_area_entered(_area):
	isLanternInRange = true

func _on_PickupAreaBox_area_exited(_area):
	isLanternInRange = false
