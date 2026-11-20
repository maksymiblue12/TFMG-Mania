class_name BeltPath
extends Node2D

var BELT_ITEM=preload("res://systems/belt_path/belt_item.tscn")

var _id:int

var curve:Curve2D

var segments:Array[BasicBelt]=[]

var items:Array[BeltItem]=[]
var wants_to_push:bool=false

var length:float=0.0
var speed:float=100.0
var item_spacing:float=30.0

func _ready() -> void:
	curve=Curve2D.new()

func get_distance_to_last():
	if (items.is_empty()):
		return length
	return items[-1].offset

func add_belt(belt:BasicBelt):
	belt.belt_path=self
	if (!segments.is_empty()):
		segments[-1].disable_ejector()
		belt.disable_acceptor()
	segments.append(belt)
	belt.start_curve_index=curve.point_count
	belt.calculate_animation_speed(speed)
	for i in belt.get_points_for_path():
		curve.add_point(i)
	belt.end_curve_index=curve.point_count
	length=curve.get_baked_length()

func add_belt_before(belt:BasicBelt):
	belt.belt_path=self
	if (!segments.is_empty()): segments[0].acceptor_active=false
	segments.insert(0,belt)
	belt.start_curve_index=0
	belt.calculate_animation_speed(speed)
	var old_l=length
	var p=belt.get_points_for_path()
	p.reverse()
	var j=0
	for i in p:
		j+=1
		curve.add_point(i,Vector2.ZERO,Vector2.ZERO,0)
	belt.start_curve_index=j
	for b in segments.slice(1):
		b.start_curve_index+=j
		b.end_curve_index+=j
	length=curve.get_baked_length()
	var l_diff=length-old_l
	for i in items:
		i.offset+=l_diff

func merge(other:BeltPath):
	if (other._id==_id): return
	for s in other.segments:
		add_belt(s)
	for i in other.items:
		i.reparent(self)
		i.offset+=length
	items=other.items+items
	GameState.belt_manager.remove_path(other)

func split(belt:BasicBelt):
	var i=segments.find(belt)
	var front=segments.slice(i+1)
	var back=segments.slice(0,i)

	var front_items:Array[BeltItem]=[]
	var back_items:Array[BeltItem]=[]
	var s=curve.get_closest_offset(curve.get_point_position(belt.start_curve_index))
	var e=curve.get_closest_offset(curve.get_point_position(belt.end_curve_index))
	for it in items:
		if (it.offset<s):
			back_items.append(it)
		elif (it.offset>e):
			it.offset-=e
			front_items.append(it)

	var front_path=GameState.belt_manager.new_belt_path(front[0])
	var back_path=GameState.belt_manager.new_belt_path(back[0])
	for j in range(1,front.size()):
		front_path.add_belt(front[j])
	for j in range(1,back.size()):
		back_path.add_belt(back[j])
	front_path.items=front_items
	back_path.items=back_items
	GameState.belt_manager.remove_path(self)

func add_item(item_type:GameConstants.ITEM_TYPE):
	var item:BeltItem=BELT_ITEM.instantiate()
	add_child(item)
	items.append(item)
	item.create(item_type)

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

func set_speed(new_speed:float):
	speed=new_speed
	for s in segments:
		s.calculate_animation_speed(speed)

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
