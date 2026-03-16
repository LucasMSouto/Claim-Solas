extends Camera3D

@export var focalLenght_lerp_power: float = 0.97
#aim camera FOV
const VIRTUAL_SENSOR_SIZE_MM = 36.0 #35mm is full frame
#@export_range(0,179,0.1,"degrees") var cameraFOV: float = 70
#@export_range(0,179,0.1,"degrees") var aimFOV: float = 30
@export_range(1,800,1, "Focal Lenght of the Camera's Lenses in mm") var cameraFocalLenght: float = 24 #in mm #set as 0 to use FOV instead
@export_range(1,800,1, "Focal Lenght of the Camera's Lenses during aim action in mm") var aimFocalLenght: float = 52

@onready var aim := false

#Current camera focal lenght values
var FocalLenght: float

func _ready() -> void:
	FocalLenght = cameraFocalLenght
	
func _physics_process(delta: float) -> void:
	zoomInOut(delta)

func zoomInOut(delta: float) -> void:
	$".".fov = lerp($".".fov,__zoom(),delta*focalLenght_lerp_power)

'''Returns current Focal Lenght value'''
func __zoom() -> float:
	if !aim:
		return get_cameraFOV()
	else:
		return get_aimFov()

func set_aim(isAiming: bool) -> void:
	aim = isAiming

'''Converts from Cinematic Focal Lenght to FOV degrees required by the engine to set the camera zoom'''
func get_cameraFOV() -> float:
	return rad_to_deg(2 * atan(VIRTUAL_SENSOR_SIZE_MM/(2*FocalLenght)))
	
func get_aimFov() -> float:
	return rad_to_deg(2* atan(VIRTUAL_SENSOR_SIZE_MM/(2*aimFocalLenght)))
	
func set_camera_FocalLenght(new_focal_lenght: float) -> void:
	if new_focal_lenght <= 0:
		FocalLenght = cameraFocalLenght
		return
	FocalLenght = new_focal_lenght
