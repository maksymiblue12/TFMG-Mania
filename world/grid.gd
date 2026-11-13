class_name Grid
extends Node2D

var SQUARE=preload("res://world/square.tscn")

var grid_id=1
var grids:Dictionary={}

func _ready() -> void:
	create_grid(Vector2.ZERO,10,10)

func create_grid(start:Vector2,width:int,height:int):
	grids[grid_id]={"size":Vector2(width,height),"bounds":Rect2(start,Vector2(width*64,height*64)),"selected":Vector2i.ZERO}
	for i in range(width):
		for j in range(height):
			create_square(start,i,j,grid_id)
	grid_id+=1

func create_square(start,x,y,_id):
	var s=SQUARE.instantiate()
	add_child(s)
	s.create(self,x,y,_id)
	s.global_position=start+Vector2(64*x,64*y)
	grids[_id][Vector2i(x,y)]=s

func get_square(_id,x,y):
	return grids[_id][Vector2i(x,y)]

func get_square_or_null(_id,x,y):
	return grids[_id].get(Vector2i(x,y))

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseMotion):
		for k in grids.keys():
			var v=grids[k]
			if (!v["bounds"].has_point(get_global_mouse_position())):
				v[v["selected"]]._on_mouse_exited()
				continue
			var pos=Vector2i((get_global_mouse_position()-v["bounds"].position)/64)
			v[pos]._on_mouse_entered()
			if (v["selected"]!=pos):
				v[v["selected"]]._on_mouse_exited()
			v["selected"]=pos
