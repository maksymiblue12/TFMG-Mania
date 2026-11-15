extends Node

signal rotated_tile_to_place

var belt_manager:BeltManager

var tile_to_place:Building=Furnace.new()

func _ready() -> void:
	belt_manager=get_tree().root.get_node("/root/world/BeltManager")

func get_placable_tile():
	return tile_to_place.get_copy()

func set_placable_tile(tile:PackedScene):
	tile_to_place=tile.instantiate()

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("rotate_building")):
		tile_to_place.rotate_tile()
		rotated_tile_to_place.emit()
