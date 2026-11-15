class_name ItemBlackHole
extends ItemAcceptor

func _init() -> void:
	super._init()
	scene=preload("res://tiles/item_black_hole/item_black_hole.tscn")
	components.append("item_black_hole")
	rotatable=false

func on_item_accepted():
	pop_accepted_item()
