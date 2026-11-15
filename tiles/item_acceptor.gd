class_name ItemAcceptor
extends BaseBuilding

var accepted_item:GameConstants.ITEM_TYPE=GameConstants.ITEM_TYPE.NONE
var acceptor_active:bool=true
var blocked_acceptor_directions:Array[bool]=[false,false,false,false]

func _init() -> void:
	super._init()
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

func copy_to(tile):
	super.copy_to(tile)
	tile.accepted_item=accepted_item
	tile.acceptor_active=acceptor_active
