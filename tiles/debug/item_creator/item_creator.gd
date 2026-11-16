class_name ItemCreator
extends BaseBuilding

@onready var timer:Timer=$Timer

var SCREEN=preload("res://tiles/debug/item_creator/item_creator_screen.tscn")

var item_type:GameConstants.ITEM_TYPE=GameConstants.ITEM_TYPE.iron

func _init() -> void:
	super._init()
	scene=preload("res://tiles/debug/item_creator/item_creator.tscn")
	components.append("debug")
	components.append("item_creator")
	rotatable=false

func on_interact():
	var s=SCREEN.instantiate()
	s.load_data(item_type,timer.wait_time,self.on_close_screen)
	GameState.ui.show_screen(s)

func on_close_screen(new_item_type:GameConstants.ITEM_TYPE,new_frequence:float):
	item_type=new_item_type
	timer.start(new_frequence)
	GameState.ui.hide_screen()

func _on_timer_timeout():
	for i in GameConstants.DIRECTION.values():
		var t=square.get_direction_neighbours()[i]
		if (t and t.has_tile and t.tile.has_component("item_acceptor")):
			t.tile.try_accept_item(item_type,i)
