extends Camera3D

@export var spring_arm: Node3D
@export var lerp_power: float = 1.0

#aim offsets
@export var cameraAimOfset: Vector3 = Vector3(1,0,0)
@onready var originalCameraPosition: Vector3 = $".".position

#aim camera FOV
const VIRTUAL_SENSOR_SIZE_MM = 36.0 #35mm is full frame
#@export_range(0,179,0.1,"degrees") var cameraFOV: float = 70
#@export_range(0,179,0.1,"degrees") var aimFOV: float = 30
@export_range(1,1000,1, "Focal Lenght of the Camera's Lenses in mm") var cameraFocalLenght: float = 24 #in mm #set as 0 to use FOV instead
@export_range(1,1000,1, "Focal Lenght of the Camera's Lenses during aim action in mm") var aimFocalLenght: float = 52

func _process(delta: float) -> void:
	var cameraAim = __aim(delta)
	position = lerp(position, spring_arm.position + cameraAim,delta*lerp_power)
	
#aim input
func __aim(delta: float) -> Vector3:
	#aim
	if Input.is_action_pressed("aim"):
		$".".fov = lerp($".".fov,get_aimFov(),delta*lerp_power)
		return cameraAimOfset
	else:
		$".".fov = lerp($".".fov,get_cameraFOV(),delta*lerp_power)
		return Vector3.ZERO
		

'''Converts from Cinematic Focal Lenght to FOV degrees required by the engine to set the camera zoom'''
func get_cameraFOV() -> float:
	return rad_to_deg(2 * atan(VIRTUAL_SENSOR_SIZE_MM/(2*cameraFocalLenght)))
	
func get_aimFov() -> float:
	return rad_to_deg(2* atan(VIRTUAL_SENSOR_SIZE_MM/(2*aimFocalLenght)))
