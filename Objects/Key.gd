extends Node2D

onready var key = $Key

func _ready():
	pass # Replace with function body.

func pickup_key():
	key.visible = false
