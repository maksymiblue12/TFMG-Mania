extends Camera2D


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	var movement=Input.get_vector("camera_left","camera_right","camera_up","camera_down")
	position+=movement*5
