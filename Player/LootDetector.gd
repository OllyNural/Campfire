extends Node2D

var isLanternInRange: bool = false

signal lantern_picked_up
signal key_picked_up
signal lantern_toggle_state
signal trigger_tooltip

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_pickup") && isLanternInRange:
		emit_signal("lantern_picked_up")
	
	if Input.is_action_just_pressed("ui_toggle") && isLanternInRange:
		emit_signal("lantern_toggle_state")

func _on_PickupAreaBox_area_entered(area):
	match area.get_parent().name:
		'Lantern':
			emit_signal('trigger_tooltip', 'lantern')
			isLanternInRange = true
		'Key':
			emit_signal('trigger_tooltip', 'key')
			emit_signal('key_picked_up')
			area.get_parent().pickup_key()

func _on_PickupAreaBox_area_exited(area):
	match area.get_parent().name:
		'Lantern':
			isLanternInRange = false
