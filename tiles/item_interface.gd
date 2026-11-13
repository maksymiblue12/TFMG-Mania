class_name ItemInterface
extends BaseBuilding

var item_to_eject:GameConstants.ITEM_TYPE=GameConstants.ITEM_TYPE.NONE
var ejector_active:bool=true
var accepted_item:GameConstants.ITEM_TYPE=GameConstants.ITEM_TYPE.NONE
var acceptor_active:bool=true

func _init() -> void:
	super._init()
	components.append("item_ejector")
	components.append("item_acceptor")

func on_item_accepted():
	pass

func pop_accepted_item():
	var t=accepted_item
	accepted_item=GameConstants.ITEM_TYPE.NONE
	return t

func can_accept_item():
	return true

func try_accept_item(item_type:GameConstants.ITEM_TYPE):
	if (!acceptor_active or !can_accept_item()): return false
	if (accepted_item==GameConstants.ITEM_TYPE.NONE):
		accepted_item=item_type
		on_item_accepted()
		return true
	return false

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
	tile.accepted_item=accepted_item
	tile.acceptor_active=acceptor_active

func _process(_delta: float) -> void:
	super._process(_delta)
	if (!ejector_active or item_to_eject==GameConstants.ITEM_TYPE.NONE): return
	var sq=square.get_direction_neighbours()[dir]
	if (sq and sq.has_tile and sq.tile.has_component("item_acceptor")):
		var t=sq.tile
		if (t.try_accept_item(item_to_eject)):
			item_to_eject=GameConstants.ITEM_TYPE.NONE
			on_item_ejected()
