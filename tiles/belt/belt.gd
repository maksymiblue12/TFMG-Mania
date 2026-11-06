class_name Belt
extends Node2D

var BELT_PATH=preload("res://tiles/belt/belt_path.tscn")

var belt_path:BeltPath
var square:Square
var dir:GameConstants.DIRECTION=GameConstants.DIRECTION.UP

func _ready() -> void:
	var back_tile=square.get_direction_neighbours()[GameConstants.OPPOSITE_DIRECTION[dir]]
	if (back_tile and back_tile.has_tile and back_tile.tile.dir==dir):
		belt_path=back_tile.tile.belt_path
		belt_path.add_belt(self)
	if (!belt_path):
		belt_path=BELT_PATH.instantiate()
		get_tree().root.add_child(belt_path)
		belt_path.add_belt(self)
	var front_tile=square.get_direction_neighbours()[dir]
	if (front_tile and front_tile.has_tile):
		belt_path.merge(front_tile.tile.belt_path)

func update_sprite():
	if (dir==GameConstants.DIRECTION.RIGHT):$Sprite2D.rotation_degrees=90
	elif (dir==GameConstants.DIRECTION.LEFT):$Sprite2D.rotation_degrees=270
	elif (dir==GameConstants.DIRECTION.DOWN):$Sprite2D.rotation_degrees=180
	elif (dir==GameConstants.DIRECTION.UP):$Sprite2D.rotation_degrees=0

func get_center():
	return global_position+$Sprite2D.get_rect().size/2

func get_side():
	return global_position+$Sprite2D.get_rect().size/2+$Sprite2D.get_rect().size/2*GameConstants.DIRECTION_TO_VECTOR[dir]*Vector2(0,-1)

func _process(_delta: float) -> void:
	pass
