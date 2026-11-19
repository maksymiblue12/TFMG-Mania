class_name FurnaceScreen
extends Control

@onready var item:TextureRect=$CenterContainer/Panel/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Item
@onready var fuel:TextureRect=$CenterContainer/Panel/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Fuel
@onready var output:TextureRect=$CenterContainer/Panel/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/HBoxContainer2/Output
@onready var progress_bar:ProgressBar=$CenterContainer/Panel/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/ProgressBar
@onready var no_recipe_label:Label=$CenterContainer/Panel/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/VBoxContainer2/Label

var input_item:GameConstants.ITEM_TYPE
var fuel_item:GameConstants.ITEM_TYPE
var output_item:GameConstants.ITEM_TYPE
var timer:Timer
var end_function:Callable

func load_data(i:GameConstants.ITEM_TYPE,f:GameConstants.ITEM_TYPE,o:GameConstants.ITEM_TYPE,_timer:Timer,_end_function:Callable):
	input_item=i
	fuel_item=f
	output_item=o
	timer=_timer
	end_function=_end_function

func _ready() -> void:
	item.texture=GameConstants.ITEM_TYPE_TO_TEXTURE[input_item]
	fuel.texture=GameConstants.ITEM_TYPE_TO_TEXTURE[fuel_item]
	output.texture=GameConstants.ITEM_TYPE_TO_TEXTURE[output_item]

func _process(_delta: float) -> void:
	if (timer.is_stopped()):
		progress_bar.visible=false
		no_recipe_label.visible=true
	else:
		progress_bar.visible=true
		no_recipe_label.visible=false
		progress_bar.ratio=1.0-timer.time_left/timer.wait_time

func _on_button_pressed() -> void:
	end_function.call()
