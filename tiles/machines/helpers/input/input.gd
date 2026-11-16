class_name MultiTileInput
extends ItemAcceptor

var controller:BaseMultiTileBuilding

func _init() -> void:
	super._init()
	scene=preload("res://tiles/machines/helpers/input/input.tscn")
	components.append("multitile_part")

func _ready() -> void:
	super._ready()
	square.mouse_enter.connect(self.on_mouse_enter)

func on_mouse_enter(enter:bool,interaction:bool):
	if (!enter):
		controller.square.stop_highlight()
	elif (interaction and enter):
		controller.square.highlight(true)
