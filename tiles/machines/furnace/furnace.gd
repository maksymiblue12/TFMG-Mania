class_name Furnace
extends BaseMultiTileBuilding

func _init() -> void:
	super._init()
	scene=preload("res://tiles/machines/furnace/furnace.tscn")
	size=Vector2(3,2)
	special_tiles={
		"input1":{"position":Vector2(0,0),"type":"input"},
		"input2":{"position":Vector2(0,1),"type":"input"},
		"output":{"position":Vector2(2,1),"type":"output"},
	}
	controller_position=Vector2(1,0)

func _ready() -> void:
	super._ready()
	special_tile_lookup["output"].dir=GameConstants.DIRECTION.RIGHT

func _process(_delta: float) -> void:
	super._process(_delta)
	if (special_tile_lookup["input1"].has_accepted_item() and special_tile_lookup["input2"].has_accepted_item()):
		special_tile_lookup["output"].try_set_ejector_item(GameConstants.ITEM_TYPE.iron)
		special_tile_lookup["input1"].pop_accepted_item()
		special_tile_lookup["input2"].pop_accepted_item()
