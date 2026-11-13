class_name BaseBuilding
extends Node2D

var scene:PackedScene
var components:PackedStringArray=PackedStringArray()

var square:Square
var dir:GameConstants.DIRECTION=GameConstants.DIRECTION.UP

func _init() -> void:
	pass

func _ready() -> void:
	update_sprite_direction()

func get_direction():
	return dir

func rotate_tile():
	dir=GameConstants.NEXT_DIRECTION[dir]

func update_sprite_direction():
	if (dir==GameConstants.DIRECTION.RIGHT):$Sprite2D.rotation_degrees=90
	elif (dir==GameConstants.DIRECTION.LEFT):$Sprite2D.rotation_degrees=270
	elif (dir==GameConstants.DIRECTION.DOWN):$Sprite2D.rotation_degrees=180
	elif (dir==GameConstants.DIRECTION.UP):$Sprite2D.rotation_degrees=0

func get_center():
	return global_position+$Sprite2D.get_rect().size/2

func get_direction_side(dirc):
	return global_position+$Sprite2D.get_rect().size/2+$Sprite2D.get_rect().size/2*GameConstants.DIRECTION_TO_VECTOR[dirc]*Vector2(1,-1)

func has_component(c:String):
	return components.has(c)

func copy_to(tile):
	tile.dir=dir

func get_copy():
	var b=scene.instantiate()
	copy_to(b)
	return b

func _process(_delta: float) -> void:
	pass
