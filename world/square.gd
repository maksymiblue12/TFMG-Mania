class_name Square
extends Node2D

@onready var panel:Panel=$Panel

signal mouse_enter(enter:bool,interact:bool)

var grid:Grid
var x_index:int
var y_index:int
var grid_id:int

var stylebox:StyleBoxFlat
var has_mouse:bool=false

var has_tile:bool=false
var tile

func create(_grid,x,y,_grid_id):
	panel.size=GameConstants.SQUARE_SIZE
	grid=_grid
	x_index=x
	y_index=y
	grid_id=_grid_id
	var s=(panel.get_theme_stylebox("panel") as StyleBoxFlat).duplicate()
	s.border_width_left=(4.0 if x_index==0 else 2.0)/60.0*GameConstants.SQUARE_SIZE.x
	s.border_width_right=(4.0 if x_index==grid.grids[grid_id]["size"].x-1 else 2.0)/60.0*GameConstants.SQUARE_SIZE.x
	s.border_width_top=(4.0 if y_index==0 else 2.0)/60.0*GameConstants.SQUARE_SIZE.x
	s.border_width_bottom=(4.0 if y_index==grid.grids[grid_id]["size"].y-1 else 2.0)/60.0*GameConstants.SQUARE_SIZE.x
	panel.add_theme_stylebox_override("panel",s)
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

func get_square_relative(offset:Vector2):
	return grid.get_square_or_null(grid_id,x_index+offset.x,y_index+offset.y)

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("mouse_left")):
		if (!has_mouse): return
		if (!has_tile and GameState.tool==GameConstants.TOOL_TYPE.place):
			set_tile(GameState.get_placable_tile())
		elif (has_tile and GameState.tool==GameConstants.TOOL_TYPE.interact):
			tile.on_interact()

func set_tile(_tile:Node2D,reparent_instead:bool=false):
	has_tile=true
	tile=_tile
	tile.z_index=1
	tile.square=self
	if (reparent_instead):
		tile.reparent(self)
	else:
		add_child(tile)

func highlight(interaction:bool):
	if (interaction):
		modulate=Color(1.0, 0.8, 0.8, 1.0)
	else:
		stylebox.bg_color=Color(0.0, 0.033, 1.0, 0.25)

func stop_highlight():
	modulate=Color(1,1,1)
	stylebox.bg_color=Color(0.0, 0.0, 0.0, 0.0)

func _on_mouse_entered() -> void:
	if (has_mouse):return
	has_mouse=true
	if (GameState.tool==GameConstants.TOOL_TYPE.interact):
		if (has_tile):
			mouse_enter.emit(true,true)
			highlight(true)
	else:
		mouse_enter.emit(true,false)
		highlight(false)

func _on_mouse_exited() -> void:
	if (!has_mouse):return
	has_mouse=false
	mouse_enter.emit(false,false)
	stop_highlight()
