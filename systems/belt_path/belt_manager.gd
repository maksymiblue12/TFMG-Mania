class_name BeltManager
extends Node2D

var BELT_PATH=preload("res://systems/belt_path/belt_path.tscn")

var current_id:int=0

var belt_paths:Array[BeltPath]=[]

func _ready() -> void:
	GameState.belt_manager=self

func is_belt(sq:Square,dir:GameConstants.DIRECTION):
	return sq and sq.has_tile and sq.tile.has_component("basic_belt") and sq.tile.get_direction()==dir

func is_belt_front(sq:Square,dir:GameConstants.DIRECTION):
	if (!(sq and sq.has_tile and sq.tile.has_component("basic_belt"))): return
	if (sq.tile.has_component("belt_corner")):
		return sq.tile.get_starting_direction()==dir
	return sq.tile.get_direction()==dir

func on_belt_added(belt:Belt):
	var sq=belt.square
	var back_tile=sq.get_direction_neighbours()[GameConstants.OPPOSITE_DIRECTION[belt.dir]]
	var front_tile=sq.get_direction_neighbours()[belt.dir]
	if (is_belt(back_tile,belt.dir) and !is_belt_front(front_tile,belt.dir)):
		back_tile.tile.belt_path.add_belt(belt)
	elif (!is_belt(back_tile,belt.dir) and is_belt_front(front_tile,belt.dir)):
		front_tile.tile.belt_path.add_belt_before(belt)
	elif (is_belt(back_tile,belt.dir) and is_belt_front(front_tile,belt.dir)):
		back_tile.tile.belt_path.add_belt(belt)
		belt.belt_path.merge(front_tile.tile.belt_path)
	else:
		new_belt_path(belt)

func on_belt_corner_added(belt:BeltCorner):
	var sq=belt.square
	var bd=GameConstants.OPPOSITE_DIRECTION[belt.get_starting_direction()]
	var back_tile=sq.get_direction_neighbours()[belt.get_starting_direction()]
	var front_tile=sq.get_direction_neighbours()[belt.get_direction()]
	if (is_belt(back_tile,bd) and !is_belt_front(front_tile,belt.get_direction())):
		back_tile.tile.belt_path.add_belt(belt)
	elif (!is_belt(back_tile,bd) and is_belt_front(front_tile,belt.get_direction())):
		front_tile.tile.belt_path.add_belt_before(belt)
	elif (is_belt(back_tile,bd) and is_belt_front(front_tile,belt.get_direction())):
		back_tile.tile.belt_path.add_belt(belt)
		belt.belt_path.merge(front_tile.tile.belt_path)
	else:
		new_belt_path(belt)

func new_belt_path(belt:BasicBelt):
	var p:BeltPath=BELT_PATH.instantiate()
	add_child(p)
	belt_paths.append(p)
	p.add_belt(belt)
	p._id=current_id
	current_id+=1
	return p

func remove_path(path:BeltPath):
	belt_paths.remove_at(belt_paths.find(path))
	path.queue_free()
