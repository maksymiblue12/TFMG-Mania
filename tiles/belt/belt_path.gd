class_name BeltPath
extends Node2D

@onready var path:Path2D=$Path2D

var items_head:BeltItem
var items_tail:BeltItem
var items_length:int
var length:int=0

var BELT_ITEM=preload("res://tiles/belt/belt_item.tscn")

func _ready() -> void:
	path.curve=Curve2D.new()

func add_belt(b):
	length+=1
	path.curve.add_point(b.get_center())
	path.curve.add_point(b.get_side())
	if (items_head):
		items_head.update_dist_to_next(path.curve.get_baked_length())

func remove():
	queue_free()

func merge(other:BeltPath):
	return
	for p in range(other.path.curve.point_count):
		path.curve.add_point(other.path.curve.get_point_position(p))
	length+=other.length

	var it=other.items_head
	while (it):
		it.reparent(path)
		it.recalculate_progress(path.curve.get_baked_length())
		it=it.prev

	if (other.items_tail):
		other.items_tail.prev=items_head
		if (items_head):
			items_head.update_dist_to_next(path.curve.get_baked_length())
	if (items_head):
		items_head.next=other.items_tail
	items_head=other.items_head
	if (!items_tail): items_tail=other.items_tail

	#other.remove()

	print(other.path.get_children())

	it=other.items_head
	while (it):
		it.reparent(path)
		it=it.prev

	print(other.path.get_children())

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("ui_accept")):
		try_add_item("aaa")

func _physics_process(delta: float) -> void:
	if (!items_head): return
	var it=items_head.get_item_to_move()
	if (it):
		it.move(delta)
	if (items_head.)

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
