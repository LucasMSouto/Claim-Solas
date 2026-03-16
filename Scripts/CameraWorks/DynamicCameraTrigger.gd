extends Node

@onready var PlayerCamera = get_tree().get_nodes_in_group("Player")[0].get_player_camera()

@export_range(0,800) var DyanamicCameraFocalLenght: float = 56

func _on_body_entered(body: Node3D) -> void:
	PlayerCamera.set_camera_FocalLenght(DyanamicCameraFocalLenght)
