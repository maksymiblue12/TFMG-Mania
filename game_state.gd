extends Node

var belt_manager:BeltManager

var tile_to_place:BaseBuilding=Belt.new()

func _ready() -> void:
	belt_manager=get_tree().root.get_node("/root/world/BeltManager")

func get_placable_tile():
	return tile_to_place.get_copy()

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("rotate_building")):
		tile_to_place.rotate_tile()
	elif (event.is_action_pressed("change_building")):
		print("d")
		print(tile_to_place.components)
		if (tile_to_place.has_component("belt")):
			tile_to_place=BeltCorner.new()
		else:
			print("a")
			tile_to_place=Belt.new()
