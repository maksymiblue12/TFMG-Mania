class_name MultiTileInput
extends ItemAcceptor

func _init() -> void:
	super._init()
	scene=preload("res://tiles/machines/helpers/input/input.tscn")
	components.append("multitile_part")
