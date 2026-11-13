class_name BeltItem
extends Node2D

var item_type
var offset:float=0
var distance_to_next:float

func create(_item_type) -> void:
	item_type=_item_type
