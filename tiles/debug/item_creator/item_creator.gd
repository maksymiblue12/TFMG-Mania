class_name ItemCreator
extends BaseBuilding

var SCREEN=preload("res://tiles/debug/item_creator/item_creator_screen.tscn")

func _init() -> void:
	super._init()
	scene=preload("res://tiles/debug/item_creator/item_creator.tscn")
	components.append("debug")
	components.append("item_creator")
	rotatable=false

func on_interact():
	GameState.ui.show_screen(SCREEN)

func _on_timer_timeout():
	for i in GameConstants.DIRECTION.values():
		var t=square.get_direction_neighbours()[i]
		if (t and t.has_tile and t.tile.has_component("item_acceptor")):
			t.tile.try_accept_item(GameConstants.ITEM_TYPE.iron,i)
