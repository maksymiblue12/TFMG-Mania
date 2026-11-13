class_name BeltCorner
extends BasicBelt

var flipped:bool=false

func _init() -> void:
	super._init()
	scene=preload("res://tiles/belt/belt_corner.tscn")
	components.append("belt_corner")
	dir=GameConstants.DIRECTION.RIGHT

func get_direction():
	return GameConstants.OPPOSITE_DIRECTION[dir] if flipped else dir

func get_starting_direction():
	return GameConstants.NEXT_DIRECTION[GameConstants.OPPOSITE_DIRECTION[dir]] if flipped else GameConstants.NEXT_DIRECTION[dir]

func get_points_for_path():
	return [get_direction_side(GameConstants.NEXT_DIRECTION[dir]),get_center(),get_direction_side(dir)]

func _ready() -> void:
	super._ready()
	GameState.belt_manager.on_belt_corner_added(self)

func copy_to(tile):
	super.copy_to(tile)
	tile.flipped=flipped
