class_name RecipeManager
extends Node2D

var recipes:Dictionary={}

func _init() -> void:
	var path="res://assets/recipes/"
	for subf in DirAccess.open(path).get_directories():
		load_category(path.path_join(subf),subf)

func load_recipe_file(text:String):
	# TODO: check if exists and check for errors
	return JSON.new().parse_string(text)

func load_category(path:String,category:String):
	recipes[category]=[]
	for f in DirAccess.open(path).get_files():
		var data=load_recipe_file(FileAccess.open(path.path_join(f),FileAccess.READ).get_as_text())
		recipes[category].append(data)

func get_recipes(category:String):
	return recipes[category]

func format_item(item):
	if (item is String):
		return GameConstants.STRING_TO_ITEM_TYPE[item]
	assert(false)
