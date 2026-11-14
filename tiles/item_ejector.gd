class_name ItemEjector
extends BaseBuilding

var item_to_eject:GameConstants.ITEM_TYPE=GameConstants.ITEM_TYPE.NONE
var ejector_active:bool=true

func _init() -> void:
	super._init()
	components.append("item_ejector")

func try_set_ejector_item(item_type:GameConstants.ITEM_TYPE):
	if (item_to_eject==GameConstants.ITEM_TYPE.NONE):
		item_to_eject=item_type
		return true
	return false

func clear_ejector_item():
	item_to_eject=GameConstants.ITEM_TYPE.NONE

func on_item_ejected():
	pass

func copy_to(tile):
	super.copy_to(tile)
	tile.item_to_eject=item_to_eject
	tile.ejector_active=ejector_active

func _process(_delta: float) -> void:
	super._process(_delta)
	if (!ejector_active or item_to_eject==GameConstants.ITEM_TYPE.NONE): return
	var sq=square.get_direction_neighbours()[get_direction()]
	if (sq and sq.has_tile and sq.tile.has_component("item_acceptor")):
		var t=sq.tile
		if (t.try_accept_item(item_to_eject)):
			item_to_eject=GameConstants.ITEM_TYPE.NONE
			on_item_ejected()
