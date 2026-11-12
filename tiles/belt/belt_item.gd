class_name BeltItem
extends PathFollow2D

var item_type
var distance_to_next:float

func create(_item_type) -> void:
	item_type=_item_type
