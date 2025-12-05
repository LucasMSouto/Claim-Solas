extends Node

@onready var PlayerCamera = get_tree().get_nodes_in_group("Player")[0].get_player_camera()

@export_range(1,1000) var CameraFocalLenghtEntering: float = 56
@export_range(1,1000) var CameraFocalLenghtLeaving: float = 56


func _on_body_entered(body: Node3D) -> void:
	PlayerCamera.set_camera_FocalLenght(CameraFocalLenghtEntering)
