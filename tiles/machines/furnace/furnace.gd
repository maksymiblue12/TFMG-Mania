class_name Furnace
extends BaseMultiTileBuilding

@onready var timer=$Timer

var SCREEN=preload("res://tiles/machines/furnace/furnace_screen.tscn")

var item_count:int
var input_items:Dictionary={}
var output_item:GameConstants.ITEM_TYPE=GameConstants.ITEM_TYPE.NONE
var output_items:Dictionary={}
var selected_recipe:Dictionary={}

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
	set_recipe(GameState.recipe_manager.get_recipes("furnace")[0])

func _ready() -> void:
	super._ready()
	special_tile_lookup["output"].dir=GameConstants.DIRECTION.RIGHT

func get_recipe_names()->Array:
	var out=GameState.recipe_manager.get_recipes("furnace").map(func (a):return a["name"])
	out.sort()
	return out

func on_interact():
	var s=SCREEN.instantiate()
	s.load_data(selected_recipe,self,timer,get_recipe_names(),self.on_close_screen)
	GameState.ui.show_screen(s)

func on_close_screen():
	GameState.ui.hide_screen()

func add_input_item(item_type):
	if (item_type not in input_items):
		input_items[item_type]=0
	input_items[item_type]+=1
	item_count+=1

func add_output_item(item_type):
	if (output_item==GameConstants.ITEM_TYPE.NONE):
		output_item=item_type
		output_items[output_item]=0
	output_items[output_item]+=1

func can_accept_item(tile_name:String,item_type:GameConstants.ITEM_TYPE,_from_dir:GameConstants.DIRECTION):
	if (selected_recipe.is_empty()):
		return false
	return selected_recipe[tile_name]==item_type

func get_output_item_amount(output_item_type:GameConstants.ITEM_TYPE):
	if (!output_items.has(output_item_type)): return 0
	return output_items[output_item_type]+int(special_tile_lookup["output"].item_to_eject==output_item_type)

func check_recipe():
	if (selected_recipe.is_empty() or processing_recipe): return
	var i=selected_recipe["input"]
	var f=selected_recipe["fuel"]
	if (input_items.get(i,0)>1 and input_items.get(f,0)>1):
		input_items[i]-=1
		input_items[f]-=1
		start_recipe()

func start_recipe():
	timer.start(selected_recipe["time"])
	processing_recipe=true

func set_recipe(recipe:Dictionary):
	selected_recipe=recipe.duplicate()
	selected_recipe["input"]=GameState.recipe_manager.format_item(recipe["input"])
	selected_recipe["fuel"]=GameState.recipe_manager.format_item(recipe["fuel"])
	selected_recipe["output"]=GameState.recipe_manager.format_item(recipe["output"])

func _process(_delta: float) -> void:
	super._process(_delta)
	var input:MultiTileInput=special_tile_lookup["input"]
	var fuel:MultiTileInput=special_tile_lookup["fuel"]
	var output:MultiTileOutput=special_tile_lookup["output"]
	if (input.has_accepted_item()):
		add_input_item(input.pop_accepted_item())
	if (fuel.has_accepted_item()):
		add_input_item(fuel.pop_accepted_item())
	check_recipe()
	if (output_items.get(output_item,0)>0):
		if (output.try_set_ejector_item(output_item)):
			output_items[output_item]-=1
			if (output_items[output_item]==0):
				output_item=GameConstants.ITEM_TYPE.NONE

func _on_timer_timeout() -> void:
	processing_recipe=false
	add_output_item(selected_recipe["output"])
