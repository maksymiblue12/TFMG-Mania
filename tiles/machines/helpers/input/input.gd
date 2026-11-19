class_name MultiTileInput
extends ItemAcceptor

var controller:BaseMultiTileBuilding
var special_name:String

func _init() -> void:
	super._init()
	scene=preload("res://tiles/machines/helpers/input/input.tscn")
	components.append("multitile_part")

func _ready() -> void:
	super._ready()
	square.mouse_enter.connect(self.on_mouse_enter)

func on_interact():
	controller.on_interact()

func can_accept_item(item_type:GameConstants.ITEM_TYPE,from_dir:GameConstants.DIRECTION):
	return controller.can_accept_item(special_name,item_type,from_dir)

func on_mouse_enter(enter:bool,interaction:bool):
	if (!enter):
		controller.square.stop_highlight()
	elif (interaction and enter):
		controller.square.highlight(true)
