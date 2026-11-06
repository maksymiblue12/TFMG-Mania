class_name BeltItem
extends PathFollow2D

var next:BeltItem
var prev:BeltItem
var dist_to_next:float=0
var item_type

var dist_between_items:int=30
var speed=100

func create(_item_type,path_length) -> void:
	item_type=_item_type
	update_dist_to_next(path_length)

func update_dist_to_next(path_length):
	if (!next):
		dist_to_next=path_length-progress
	else:
		dist_to_next=next.progress-progress

func move(delta:float):
	var d=min(speed*delta,get_dist_to_next())
	progress+=d
	dist_to_next-=d
	if (prev):
		prev.move_dist(d)

func move_dist(d:float):
	progress+=d
	if (prev):
		prev.move_dist(d)

func get_dist_to_next():
	if (!next):
		return dist_to_next
	return dist_to_next-dist_between_items

func get_item_to_move():
	if (get_dist_to_next()>0):
		return self
	if (prev):
		return prev.get_item_to_move()
	return null
