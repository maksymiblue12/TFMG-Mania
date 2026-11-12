class_name BeltPath
extends Node2D

@onready var path:Path2D=$Path2D

var segments:Array[Belt]=[]

var distance_to_first:float
var items:Array[BeltItem]=[]

var length:float=0
var speed:float=100.0
var item_spacing:float=30

func _ready() -> void:
	path.curve=Curve2D.new()
