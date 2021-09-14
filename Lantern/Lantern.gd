extends KinematicBody2D

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var sprite = $Sprite

onready var lightController = $LightController

onready var fuelController = $FuelController

var is_lit = true
var can_move = true setget set_can_move
var has_fuel = true

func _ready():
	animationTree.active = true
	animationState.travel("FloorAngledOn")
	lightController.set_texture_scale(1)
	lightController.set_light_intensity(0.8)
	lightController.set_flicker_amount(1)
	lightController.set_collision_range(5)
	lightController.set_light_type("lantern")
	is_lit = true
	turn_off(0.1)
	fuelController.connect("lantern_fuel_not_empty", self, "_on_lantern_fuel_not_empty")
	fuelController.connect("lantern_fuel_empty", self, "_on_lantern_fuel_empty")

func move(flip: bool):
	animationState.travel("Run")
	flip(flip)

func idle(flip: bool):
	animationState.travel("Idle")
	flip(flip)

func jump(jump_state: String, flip: bool):
	flip(flip)
	match jump_state:
		"JumpUp":
			animationState.travel("JumpOnUp")
		"JumpDown":
			animationState.travel("JumpOnDown")
		"Land":
			animationState.travel("JumpOnLand")

func handle_dropped():
	self.global_position = global_position + Vector2(0, 4)
	animationState.travel("FloorAngledOn")

func handle_picked_up(position: Vector2):
	self.global_position = position - Vector2(0, 4)

func flip(flip: bool):
	if (flip):
		sprite.global_position = global_position - Vector2(5, 0)
	else:
		sprite.global_position = global_position - Vector2(-5, 0)

	sprite.flip_h = flip
	
func toggle_state(time: float = 0.2):
	if (is_lit):
		turn_off(time)
	else:
		turn_on(time)

func turn_on(time: float = 0.2):
	if (!is_lit):
		if (has_fuel):
			fuelController.set_lantern_on()
			lightController.fade_in(time)
	is_lit = true

func turn_off(time: float = 0.2):
	if (is_lit):
		fuelController.set_lantern_off()
		lightController.fade_out(time)
	is_lit = false

func _on_lantern_fuel_empty():
	has_fuel = false
	turn_off()

func _on_lantern_fuel_not_empty():
	has_fuel = true

func set_can_move(move: bool):
	can_move = move
	fuelController.set_can_move(move)
