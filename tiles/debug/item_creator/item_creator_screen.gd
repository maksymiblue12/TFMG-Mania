class_name ItemCreatorScreen
extends Control

@onready var item_option:OptionButton=$CenterContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/OptionButton
@onready var frequence_option:SpinBox=$CenterContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/SpinBox

var item_type:GameConstants.ITEM_TYPE
var frequence:float
var end_function:Callable

func load_data(_item_type:GameConstants.ITEM_TYPE,_f:float,_end_function:Callable):
	item_type=_item_type
	frequence=_f
	end_function=_end_function

func _ready() -> void:
	for k in GameConstants.ITEM_TYPE_TO_ID:
		item_option.add_item(GameConstants.STRING_TO_ITEM_TYPE.find_key(k),GameConstants.ITEM_TYPE_TO_ID[k])
	item_option.select(GameConstants.ITEM_TYPE_TO_ID[item_type])
	frequence_option.value=frequence

func _on_button_pressed() -> void:
	end_function.call(GameConstants.ITEM_TYPE_TO_ID.find_key(item_option.selected),frequence_option.value)
