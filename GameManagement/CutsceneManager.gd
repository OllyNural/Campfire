extends Node2D

signal cutscene_trigger
signal trigger_tooltip

func _on_Area2D_area_entered(area):
	emit_signal("cutscene_trigger")
	emit_signal('trigger_tooltip', 'end_game', 1.5)
