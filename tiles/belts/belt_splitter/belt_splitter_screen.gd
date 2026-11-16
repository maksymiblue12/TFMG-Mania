class_name BeltSplitterScreen
extends Control

@onready var item_option_1:OptionButton=$CenterContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/OptionButton
@onready var item_option_2:OptionButton=$CenterContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/OptionButton2
@onready var item_option_3:OptionButton=$CenterContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/OptionButton3

var item_type_1
var item_type_2
var item_type_3
var end_function:Callable

func load_data(_item_type_1,_item_type_2,_item_type_3,_end_function:Callable):
	item_type_1=_item_type_1
	item_type_2=_item_type_2
	item_type_3=_item_type_3
	end_function=_end_function

func _ready() -> void:
	for k in BeltSplitter.ITEM_TYPE_TO_ID:
		var v=BeltSplitter.ITEM_TYPE_TO_ID[k]
		item_option_1.add_item(k,v)
		item_option_2.add_item(k,v)
		item_option_3.add_item(k,v)
	await get_tree().process_frame
	item_option_1.update_minimum_size()
	item_option_1.get_parent().queue_sort()
	item_option_1.get_parent().get_parent().queue_sort()
	item_option_1.get_parent().get_parent().get_parent().queue_sort()
	item_option_1.get_parent().get_parent().get_parent().get_parent().update_minimum_size()
	item_option_1.select(BeltSplitter.ITEM_TYPE_TO_ID[item_type_1])
	item_option_2.select(BeltSplitter.ITEM_TYPE_TO_ID[item_type_2])
	item_option_3.select(BeltSplitter.ITEM_TYPE_TO_ID[item_type_3])

func _on_button_pressed() -> void:
	end_function.call(BeltSplitter.ITEM_TYPE_TO_ID.find_key(item_option_1.selected),BeltSplitter.ITEM_TYPE_TO_ID.find_key(item_option_2.selected),BeltSplitter.ITEM_TYPE_TO_ID.find_key(item_option_3.selected))
