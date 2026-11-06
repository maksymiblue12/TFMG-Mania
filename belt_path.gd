class_name BeltPath
extends Node2D

@onready var path=$Path2D

var items_head:BeltItem
var items_tail:BeltItem
var items_length:int

var BELT_ITEM=preload("res://belt_item.tscn")

func _ready() -> void:
	pass

func add_belt(b):
	path.curve.add_point(b.global_position)
	if (items_head):
		items_head.update_dist_to_next(path.curve.get_baked_length())

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("ui_accept")):
		try_add_item("aaa")

func _physics_process(delta: float) -> void:
	if (!items_head): return
	var it=items_head.get_item_to_move()
	if (it):
		it.move(delta)

func add_item(item_type):
	var item:BeltItem=BELT_ITEM.instantiate()
	path.add_child(item)
	item.next=items_tail
	if (items_tail):
		items_tail.prev=item
	items_tail=item
	item.create(item_type,path.curve.get_baked_length())
	if (items_length==0):
		items_head=item
	items_length+=1

func can_add_item():
	return items_tail.progress>items_tail.dist_between_items if items_tail else true

func try_add_item(item_type):
	if (can_add_item()):
		add_item(item_type)
		return true
	return false
