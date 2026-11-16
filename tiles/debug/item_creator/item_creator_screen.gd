class_name ItemCreatorScreen
extends Control

@onready var item_option:OptionButton=$CenterContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/OptionButton
@onready var frequence_option:SpinBox=$CenterContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/SpinBox

var ITEM_TYPE_TO_ID:Dictionary={
	GameConstants.ITEM_TYPE.iron:0,
	GameConstants.ITEM_TYPE.coal:1,
}

var item_type:GameConstants.ITEM_TYPE
var frequence:float
var end_function:Callable

func load_data(_item_type:GameConstants.ITEM_TYPE,_f:float,_end_function:Callable):
	item_type=_item_type
	frequence=_f
	end_function=_end_function

func _ready() -> void:
	item_option.select(ITEM_TYPE_TO_ID[item_type])
	frequence_option.value=frequence

func _on_button_pressed() -> void:
	end_function.call(ITEM_TYPE_TO_ID.find_key(item_option.selected),frequence_option.value)
