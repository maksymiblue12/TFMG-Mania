class_name Belt
extends Node2D

var belt_path:BeltPath
var square:Square
var dir:GameConstants.DIRECTION=GameConstants.DIRECTION.LEFT

func _ready() -> void:
	choose_direction()
	for n in square.get_neighbours():
		if (!n.has_tile): continue
		belt_path=n.tile.belt_path
		belt_path.add_belt(self)
		break
	if (!belt_path):
		belt_path=load("res://belt_path.tscn").instantiate()
		get_tree().root.add_child(belt_path)
		belt_path.add_belt(self)

func choose_direction():
	var ns=square.get_direction_neighbours()
	var a=ns.size()-ns.values().count(null)
	if (a==1):
		var dns=square.get_direction_neighbours()
		for k in dns.keys():
			if (!dns[k]): continue
			if (dns[k].tile.dir==GameConstants.OPPOSITE_DIRECTION[k]):
				dir=GameConstants.OPPOSITE_DIRECTION[k]
			elif (dns[k].tile.belt_path.length==1):
				dns[k].tile.dir=GameConstants.OPPOSITE_DIRECTION[k]
				dns[k].tile.update_sprite()
				dir=GameConstants.OPPOSITE_DIRECTION[k]
	update_sprite()

func update_sprite():
	if (dir==GameConstants.DIRECTION.RIGHT):$Sprite2D.rotation_degrees=90
	elif (dir==GameConstants.DIRECTION.LEFT):$Sprite2D.rotation_degrees=270
	elif (dir==GameConstants.DIRECTION.DOWN):$Sprite2D.rotation_degrees=180
	elif (dir==GameConstants.DIRECTION.UP):$Sprite2D.rotation_degrees=0

func _process(_delta: float) -> void:
	pass
