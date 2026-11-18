class_name Furnace
extends BaseMultiTileBuilding

@onready var timer=$Timer

var SCREEN=preload("res://tiles/machines/furnace/furnace_screen.tscn")

var item_count:int
var items:Dictionary={}

var processing_recipe:bool=false

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

func on_interact():
	var s=SCREEN.instantiate()
	s.load_data(timer,self.on_close_screen)
	GameState.ui.show_screen(s)

func on_close_screen():
	GameState.ui.hide_screen()

func create_item(item_type):
	if (item_type not in items):
		items[item_type]=0
	items[item_type]+=1
	item_count+=1

func check_recipe():
	var input:MultiTileInput=special_tile_lookup["input"]
	var fuel:MultiTileInput=special_tile_lookup["fuel"]
	for k in GameState.recipe_manager.get_recipes("furnace"):
		if (input.accepted_item==GameState.recipe_manager.format_item(k["input"]) and fuel.accepted_item==GameState.recipe_manager.format_item(k["fuel"])):
			start_recipe()

func start_recipe():
	timer.start()
	processing_recipe=true

func _process(_delta: float) -> void:
	super._process(_delta)
	if (processing_recipe): return
	var input:MultiTileInput=special_tile_lookup["input"]
	var fuel:MultiTileInput=special_tile_lookup["fuel"]
	if (input.has_accepted_item() and fuel.has_accepted_item()):
		check_recipe()

func _on_timer_timeout() -> void:
	var output:MultiTileOutput=special_tile_lookup["output"]
	processing_recipe=false
	output.try_set_ejector_item(GameConstants.ITEM_TYPE.iron)
