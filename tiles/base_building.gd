class_name BaseBuilding
extends Node2D

var is_belt:bool=false

var square:Square
var dir:GameConstants.DIRECTION=GameConstants.DIRECTION.UP

func _ready() -> void:
	pass # Replace with function body.

func update_sprite_direction():
	if (dir==GameConstants.DIRECTION.RIGHT):$Sprite2D.rotation_degrees=90
	elif (dir==GameConstants.DIRECTION.LEFT):$Sprite2D.rotation_degrees=270
	elif (dir==GameConstants.DIRECTION.DOWN):$Sprite2D.rotation_degrees=180
	elif (dir==GameConstants.DIRECTION.UP):$Sprite2D.rotation_degrees=0

func get_center():
	return global_position+$Sprite2D.get_rect().size/2

func get_direction_side():
	return global_position+$Sprite2D.get_rect().size/2+$Sprite2D.get_rect().size/2*GameConstants.DIRECTION_TO_VECTOR[dir]*Vector2(0,-1)


func _process(_delta: float) -> void:
	pass
