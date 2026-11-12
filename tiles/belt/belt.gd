class_name Belt
extends BaseBuilding

var BELT_PATH=preload("res://tiles/belt/belt_path.tscn")
var belt_path:BeltPath

func _init() -> void:
	is_belt=true

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

func _process(_delta: float) -> void:
	pass
