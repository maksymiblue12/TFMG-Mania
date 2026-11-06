class_name Belt
extends Node2D

var belt_path:BeltPath
var square:Square

func _ready() -> void:
	for n in square.get_neighbours():
		if (!n.has_tile): continue
		belt_path=n.tile.belt_path
		belt_path.add_belt(self)
		break
	if (!belt_path):
		belt_path=load("res://belt_path.tscn").instantiate()
		get_tree().root.add_child(belt_path)
		belt_path.add_belt(self)


func _process(_delta: float) -> void:
	pass
