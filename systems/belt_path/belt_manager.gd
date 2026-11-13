class_name BeltManager
extends Node2D

var BELT_PATH=preload("res://systems/belt_path/belt_path.tscn")

var belt_paths:Array[BeltPath]=[]

func is_belt(sq:Square,dir:GameConstants.DIRECTION):
	return sq and sq.has_tile and sq.tile.has_component("belt") and sq.tile.dir==dir

func on_belt_added(belt:Belt):
	var sq=belt.square
	var back_tile=sq.get_direction_neighbours()[GameConstants.OPPOSITE_DIRECTION[belt.dir]]
	var front_tile=sq.get_direction_neighbours()[belt.dir]
	if (is_belt(back_tile,belt.dir) and !is_belt(front_tile,belt.dir)):
		back_tile.tile.belt_path.add_belt(belt)
	elif (!is_belt(back_tile,belt.dir) and is_belt(front_tile,belt.dir)):
		front_tile.tile.belt_path.add_belt_before(belt)
	elif (is_belt(back_tile,belt.dir) and is_belt(front_tile,belt.dir)):
		back_tile.tile.belt_path.add_belt(belt)
		belt.belt_path.merge(front_tile.tile.belt_path)
	else:
		new_belt_path(belt)

func new_belt_path(belt:Belt):
	var p=BELT_PATH.instantiate()
	add_child(p)
	belt_paths.append(p)
	p.add_belt(belt)

func remove_path(path:BeltPath):
	belt_paths.remove_at(belt_paths.find(path))
	path.queue_free()
