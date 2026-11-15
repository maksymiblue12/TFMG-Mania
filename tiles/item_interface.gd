class_name ItemInterface
extends BaseBuilding

var item_to_eject:GameConstants.ITEM_TYPE=GameConstants.ITEM_TYPE.NONE
var ejector_active:bool=true
var accepted_item:GameConstants.ITEM_TYPE=GameConstants.ITEM_TYPE.NONE
var acceptor_active:bool=true
var blocked_acceptor_directions:Array[bool]=[false,false,false,false]

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

func can_accept_item(_from_dir:GameConstants.DIRECTION):
	return true

func block_all_acceptor_directions():
	blocked_acceptor_directions=[true,true,true,true]

func disable_acceptor():
	acceptor_active=false
	pop_accepted_item()

func has_accepted_item():
	return accepted_item!=GameConstants.ITEM_TYPE.NONE

func could_accept_item(from_dir:GameConstants.DIRECTION):
	return acceptor_active and !blocked_acceptor_directions[GameConstants.OPPOSITE_DIRECTION[from_dir]] and can_accept_item(from_dir) and !has_accepted_item()

func try_accept_item(item_type:GameConstants.ITEM_TYPE,from_dir:GameConstants.DIRECTION):
	if (!acceptor_active or blocked_acceptor_directions[GameConstants.OPPOSITE_DIRECTION[from_dir]]): return false
	if (!can_accept_item(from_dir)): return false
	if (!has_accepted_item()):
		accepted_item=item_type
		on_item_accepted()
		return true
	return false

func wants_to_eject():
	return item_to_eject!=GameConstants.ITEM_TYPE.NONE

func get_ejector_direction():
	return get_direction()

func try_set_ejector_item(item_type:GameConstants.ITEM_TYPE):
	if (item_to_eject==GameConstants.ITEM_TYPE.NONE):
		item_to_eject=item_type
		return true
	return false

func clear_ejector_item():
	item_to_eject=GameConstants.ITEM_TYPE.NONE

func disable_ejector():
	ejector_active=false
	clear_ejector_item()

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
	var d=get_ejector_direction()
	if (!ejector_active): return
	var sq=square.get_direction_neighbours()[d]
	if (sq and sq.has_tile and sq.tile.has_component("item_acceptor")):
		var t=sq.tile
		if (t.try_accept_item(item_to_eject,d)):
			item_to_eject=GameConstants.ITEM_TYPE.NONE
			on_item_ejected()
