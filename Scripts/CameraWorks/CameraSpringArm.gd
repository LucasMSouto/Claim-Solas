extends Node3D

@export var mouse_sensibility: float = 0.001
@export_range(-90.0, 0.0, 0.1, "radians_as_degrees") var min_vertical_angle:float = -PI/2
@export_range(0, 90.0, 0.1, "radians_as_degrees") var max_vertical_angle:float = PI/2

@onready var spring_arm := $SpringArm3D
@onready var camera := $SpringArm3D/Camera3D

func _ready() -> void:
	#Makes mouse inv, blocks and centers it on the screen
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event: InputEvent) -> void:
	#Mouse lock
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	#Mouse Motion
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotation.y -= event.relative.x * mouse_sensibility
			rotation.y = wrapf(rotation.y,0.0, TAU)
		
			rotation.x -= event.relative.y * mouse_sensibility
			rotation.x = clamp(rotation.x, min_vertical_angle, max_vertical_angle)
			
	#Aim Button Press
	if event.is_action_pressed("aim"):
		camera.set_aim(true)
	
	if event.is_action_released("aim"):
		camera.set_aim(false)
