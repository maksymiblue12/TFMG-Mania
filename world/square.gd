class_name Square
extends Node2D

@onready var panel=$Panel

var grid:Grid
var x_index:int
var y_index:int
var grid_id:int

var TILE_TYPES={
	"belt":preload("res://tiles/belt/belt.tscn")
}

var stylebox:StyleBoxFlat
var has_mouse:bool=false

var has_tile:bool=false
var tile

func create(_grid,x,y,_grid_id):
	grid=_grid
	x_index=x
	y_index=y
	grid_id=_grid_id
	var s=($Panel.get_theme_stylebox("panel") as StyleBoxFlat).duplicate()
	if (x_index==0):
		s.border_width_left=4
	if (y_index==0):
		s.border_width_top=4
	$Panel.add_theme_stylebox_override("panel",s)
	stylebox=s

func get_neighbours():
	return [
		grid.get_square_or_null(grid_id,x_index-1,y_index),
		grid.get_square_or_null(grid_id,x_index,y_index-1),
		grid.get_square_or_null(grid_id,x_index+1,y_index),
		grid.get_square_or_null(grid_id,x_index,y_index+1),
	]

func get_direction_neighbours():
	return {
		GameConstants.DIRECTION.LEFT:grid.get_square_or_null(grid_id,x_index-1,y_index),
		GameConstants.DIRECTION.UP:grid.get_square_or_null(grid_id,x_index,y_index-1),
		GameConstants.DIRECTION.RIGHT:grid.get_square_or_null(grid_id,x_index+1,y_index),
		GameConstants.DIRECTION.DOWN:grid.get_square_or_null(grid_id,x_index,y_index+1),
	}

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		if (has_mouse and !has_tile):
			set_tile()

func set_tile():
	has_tile=true
	tile=GameState.get_placable_tile()
	tile.square=self
	add_child(tile)

func _on_mouse_entered() -> void:
	if (has_mouse):return
	has_mouse=true
	stylebox.bg_color=Color(0.0, 0.033, 1.0, 0.25)

func _on_mouse_exited() -> void:
	if (!has_mouse):return
	has_mouse=false
	stylebox.bg_color=Color(0.0, 0.0, 0.0, 0.0)
