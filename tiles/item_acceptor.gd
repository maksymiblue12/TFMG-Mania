class_name ItemAcceptor
extends BaseBuilding

var accepted_item:GameConstants.ITEM_TYPE=GameConstants.ITEM_TYPE.NONE
var acceptor_active:bool=true

func _init() -> void:
	super._init()
	components.append("item_acceptor")

func on_item_accepted():
	pass

func pop_accepted_item():
	var t=accepted_item
	accepted_item=GameConstants.ITEM_TYPE.NONE
	return t

func can_accept_item():
	return true

func copy_to(tile):
	super.copy_to(tile)
	tile.accepted_item=accepted_item
	tile.acceptor_active=acceptor_active

func try_accept_item(item_type:GameConstants.ITEM_TYPE):
	if (!acceptor_active or !can_accept_item()): return false
	if (accepted_item==GameConstants.ITEM_TYPE.NONE):
		accepted_item=item_type
		on_item_accepted()
		return true
	return false
