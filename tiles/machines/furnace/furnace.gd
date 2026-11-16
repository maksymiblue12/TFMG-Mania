class_name Furnace
extends BaseMultiTileBuilding

var item_count:int
var items:Dictionary={}

func _init() -> void:
	super._init()
	scene=preload("res://tiles/machines/furnace/furnace.tscn")
	size=Vector2(3,2)
	special_tiles={
		"input":{"position":Vector2(0,0),"type":"input"},
		"fuel":{"position":Vector2(0,1),"type":"input"},
		"output":{"position":Vector2(2,1),"type":"output"},
	}
	controller_position=Vector2(1,0)

func _ready() -> void:
	super._ready()
	special_tile_lookup["output"].dir=GameConstants.DIRECTION.RIGHT

func create_item(item_type):
	if (item_type not in items):
		items[item_type]=0
	items[item_type]+=1
	item_count+=1

func check_recipe():
	var input:MultiTileInput=special_tile_lookup["input"]
	var fuel:MultiTileInput=special_tile_lookup["fuel"]
	# TODO: screen to select recipe, then filter acceptable item
	for k in GameState.recipe_manager.get_recipes("furnace"):
		if (input.accepted_item==GameState.recipe_manager.format_item(k["input"]) and fuel.accepted_item==GameState.recipe_manager.format_item(k["fuel"])):
			print("yes")

func _process(_delta: float) -> void:
	super._process(_delta)
	var input:MultiTileInput=special_tile_lookup["input"]
	var fuel:MultiTileInput=special_tile_lookup["fuel"]
	var output:MultiTileOutput=special_tile_lookup["output"]
	if (input.has_accepted_item() and fuel.has_accepted_item()):
		check_recipe()
