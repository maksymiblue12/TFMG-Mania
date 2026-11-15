class_name BaseBuilding
extends Building

@onready var sprite:Sprite2D=$Sprite2D

var scene:PackedScene
var components:PackedStringArray=PackedStringArray()

var square:Square
var dir:GameConstants.DIRECTION=GameConstants.DIRECTION.UP
var rotatable:bool=true

func _init() -> void:
	pass

func _ready() -> void:
	update_sprite_direction()

func get_direction():
	return dir

func rotate_tile():
	if (!rotatable): return
	dir=GameConstants.NEXT_DIRECTION[dir]

func update_sprite_direction():
	sprite.rotation_degrees=GameConstants.DIRECTION_TO_ROTATION[dir]

func get_center():
	return global_position+sprite.get_rect().size/2

func get_direction_side(dirc):
	return global_position+sprite.get_rect().size/2+sprite.get_rect().size/2*GameConstants.DIRECTION_TO_VECTOR[dirc]*Vector2(1,-1)

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
