class_name BeltPath
extends Node2D

var BELT_ITEM=preload("res://systems/belt_path/belt_item.tscn")

var curve:Curve2D

var segments:Array[Belt]=[]

var distance_to_first:float
var distance_to_last:float
var items:Array[BeltItem]=[]

var length:float=0
var speed:float=100.0
var item_spacing:float=30

func _ready() -> void:
	curve=Curve2D.new()

func add_belt(belt:Belt):
	belt.belt_path=self
	segments.append(belt)
	curve.add_point(belt.get_center())
	curve.add_point(belt.get_direction_side())
	length=curve.get_baked_length()

func add_belt_before(belt:Belt):
	belt.belt_path=self
	segments.insert(0,belt)
	curve.add_point(belt.get_direction_side(),Vector2.ZERO,Vector2.ZERO,0)
	curve.add_point(belt.get_center(),Vector2.ZERO,Vector2.ZERO,0)

func merge(other:BeltPath):
	segments.append_array(other.segments)
	items[0].distance_to_next=distance_to_first+other.distance_to_last
	for i in other.items:
		i.reparent(self)
	items=other.items+items
	distance_to_first=other.distance_to_first
	for i in range(other.curve.point_count):
		curve.add_point(other.curve.get_point_position(i))
	length=curve.get_baked_length()

func add_item(item_type):
	var item:BeltItem=BELT_ITEM.instantiate()
	items.append(item)
	item.item_type=item_type
	item.distance_to_next=distance_to_last
	distance_to_last=0

func _physics_process(delta: float) -> void:
	distance_to_first-=speed*delta
	distance_to_first=max(0,distance_to_first)

	for item in items:
		pass
