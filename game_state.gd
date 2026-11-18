extends Node

signal rotated_tile_to_place

var belt_manager:BeltManager
var ui:UI
var recipe_manager:RecipeManager=RecipeManager.new()

var tile_to_place:Building=BeltSplitter.new()

var tool:GameConstants.TOOL_TYPE=GameConstants.TOOL_TYPE.place

var showing_screen:bool=false

func get_placable_tile():
	return tile_to_place.get_copy()

func set_placable_tile(tile:PackedScene):
	tile_to_place=tile.instantiate()

func set_tool(tool_type:GameConstants.TOOL_TYPE):
	ui.toggle_tile_picker_screen(tool_type==GameConstants.TOOL_TYPE.place,true)
	tool=tool_type

func _input(event: InputEvent) -> void:
	if (showing_screen): return
	if (event.is_action_pressed("rotate_building")):
		tile_to_place.rotate_tile()
		rotated_tile_to_place.emit()
