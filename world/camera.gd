extends Camera2D

@export var zoom_in_amount:float=0.5
@export var zoom_out_amount:float=1.1
@export var max_zoom_out_level:int=12
@export var max_zoom_in_level:int=5

var zoom_level:int=0

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseMotion):
		if (Input.is_action_pressed("mouse_right")):
			position-=event.screen_relative*Vector2(1/zoom.x,1/zoom.y)
	elif (event is InputEventMouseButton):
		if (event.button_index==MOUSE_BUTTON_WHEEL_UP):
			if (zoom.x<1):
				zoom*=zoom_out_amount
			else:
				if (zoom.x>zoom_in_amount*(max_zoom_in_level+1)): return
				zoom+=Vector2(zoom_in_amount,zoom_in_amount)
			zoom_level+=1
		elif (event.button_index==MOUSE_BUTTON_WHEEL_DOWN):
			if (zoom.x<=1):
				if (zoom.x<(1/zoom_out_amount**(max_zoom_out_level+1))): return
				zoom/=zoom_out_amount
			else:
				zoom-=Vector2(zoom_in_amount,zoom_in_amount)
			zoom_level-=1
		elif (event.button_index==MOUSE_BUTTON_MIDDLE):
			position=Vector2.ZERO
			zoom=Vector2(1,1)
			zoom_level=0

func _process(_delta: float) -> void:
	var movement=Input.get_vector("camera_left","camera_right","camera_up","camera_down")
	position+=movement*5
