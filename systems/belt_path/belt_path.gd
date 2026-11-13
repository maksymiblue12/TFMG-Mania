class_name BeltPath
extends Node2D

var BELT_ITEM=preload("res://systems/belt_path/belt_item.tscn")

var curve:Curve2D
var line

var segments:Array[Belt]=[]

var distance_to_first:float=0.0
var items:Array[BeltItem]=[]
var wants_to_push:bool=false

var length:float=0
var speed:float=100.0
var item_spacing:float=30

func _ready() -> void:
	curve=Curve2D.new()
	line=Line2D.new()
	add_child(line)
	line.points=curve.get_baked_points()
	line.width=10
	line.default_color=Color(0,1,0)

func get_distance_to_last():
	if (items.is_empty()):
		return length
	return items[-1].offset

func add_belt(belt:Belt):
	belt.belt_path=self
	if (!segments.is_empty()): segments[-1].ejector_active=false;segments[-1].clear_ejector_item()
	segments.append(belt)
	var old_l=length
	curve.add_point(belt.get_center())
	curve.add_point(belt.get_direction_side())
	length=curve.get_baked_length()
	line.points=curve.get_baked_points()

func add_belt_before(belt:Belt):
	belt.belt_path=self
	if (!segments.is_empty()): segments[0].acceptor_active=false
	segments.insert(0,belt)
	var old_l=length
	curve.add_point(belt.get_direction_side(),Vector2.ZERO,Vector2.ZERO,0)
	curve.add_point(belt.get_center(),Vector2.ZERO,Vector2.ZERO,0)
	length=curve.get_baked_length()
	var l_diff=length-old_l
	for i in items:
		i.offset+=l_diff

func merge(other:BeltPath):
	for s in other.segments:
		add_belt(s)
	for i in other.items:
		i.reparent(self)
		i.offset+=length
	items=other.items+items
	GameState.belt_manager.remove_path(other)

func add_item(item_type:GameConstants.ITEM_TYPE):
	var item:BeltItem=BELT_ITEM.instantiate()
	add_child(item)
	items.append(item)
	item.item_type=item_type

func can_add_item():
	return get_distance_to_last()>=item_spacing or items.is_empty()

func try_add_item(item_type:GameConstants.ITEM_TYPE):
	if (can_add_item()):
		add_item(item_type)
		return true
	return false

func on_ejected_item():
	var it=items.pop_front()
	it.queue_free()
	wants_to_push=false

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_released("ui_accept")):
		try_add_item(GameConstants.ITEM_TYPE.iron)

func _process(delta: float) -> void:
	if (items.is_empty()): return

	var move=speed*delta
	var moved=0
	for i in range(items.size()):
		var item=items[i]
		var a=item.offset

		if (i==0):
			a=length-item.offset
		else:
			a=items[i-1].offset-item_spacing-item.offset

		var move_amount=min(move,a)
		moved+=move_amount
		move-=move_amount

		item.offset+=moved

	for item in items:
		item.position=curve.sample_baked(item.offset)

	wants_to_push=length-items[0].offset==0
	if (wants_to_push):
		segments[-1].try_set_ejector_item(items[0].item_type)
