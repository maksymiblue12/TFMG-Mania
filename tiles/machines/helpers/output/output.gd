class_name MultiTileOutput
extends ItemEjector

func _init() -> void:
	super._init()
	scene=preload("res://tiles/machines/helpers/output/output.tscn")
	components.append("multitile_part")
