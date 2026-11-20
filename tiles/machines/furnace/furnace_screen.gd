class_name FurnaceScreen
extends Control

@onready var recipes:OptionButton=$CenterContainer/Panel/MarginContainer/VBoxContainer/OptionButton
@onready var item:TextureRect=$CenterContainer/Panel/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Item
@onready var item_amount:Label=$CenterContainer/Panel/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Item/Label
@onready var fuel:TextureRect=$CenterContainer/Panel/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Fuel
@onready var fuel_amount:Label=$CenterContainer/Panel/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Fuel/Label
@onready var output:TextureRect=$CenterContainer/Panel/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/HBoxContainer2/Output
@onready var output_amount:Label=$CenterContainer/Panel/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/HBoxContainer2/Output/Label
@onready var progress_bar:ProgressBar=$CenterContainer/Panel/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/ProgressBar
@onready var no_recipe_label:Label=$CenterContainer/Panel/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/VBoxContainer2/Label

var recipe_names:Array
var recipe_name:String
var furnace:Furnace
var input_item:GameConstants.ITEM_TYPE
var fuel_item:GameConstants.ITEM_TYPE
var output_item:GameConstants.ITEM_TYPE
var timer:Timer
var end_function:Callable

var timer_stop_delay:float=250
var timer_stop_time:float=-1

func load_data(recipe:Dictionary,_furnace:Furnace,_timer:Timer,_recipe_names:Array,_end_function:Callable):
	recipe_names=_recipe_names
	furnace=_furnace
	input_item=recipe["input"]
	fuel_item=recipe["fuel"]
	output_item=recipe["output"]
	recipe_name=recipe["name"]
	timer=_timer
	end_function=_end_function

func _ready() -> void:
	for i in range(recipe_names.size()):
		recipes.add_item(recipe_names[i],i)
	recipes.select(recipe_names.find(recipe_name))
	item.texture=GameConstants.ITEM_TYPE_TO_TEXTURE[input_item]
	fuel.texture=GameConstants.ITEM_TYPE_TO_TEXTURE[fuel_item]
	output.texture=GameConstants.ITEM_TYPE_TO_TEXTURE[output_item]

func _process(_delta: float) -> void:
	item_amount.text=str(furnace.input_items.get(input_item,0))
	fuel_amount.text=str(furnace.input_items.get(fuel_item,0))
	output_amount.text=str(furnace.get_output_item_amount(output_item))
	if (timer.is_stopped()):
		if (timer_stop_time==-1): timer_stop_time=Time.get_ticks_msec()
		if (Time.get_ticks_msec()-timer_stop_time>timer_stop_delay):
			progress_bar.visible=false
			no_recipe_label.visible=true
	else:
		timer_stop_time=-1
		progress_bar.visible=true
		no_recipe_label.visible=false
		progress_bar.ratio=1.0-timer.time_left/timer.wait_time

func _on_button_pressed() -> void:
	end_function.call()
