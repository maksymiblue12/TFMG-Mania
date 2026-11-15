class_name MultiTileEmptyBuilding
extends BaseBuilding

func _init() -> void:
	super._init()
	scene=preload("res://tiles/machines/helpers/empty/empty.tscn")
	components.append("multitile_part")
	components.append("empty")
