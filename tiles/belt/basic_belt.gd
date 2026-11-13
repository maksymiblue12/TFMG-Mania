class_name BasicBelt
extends ItemInterface

var belt_path:BeltPath

func get_points_for_path():
	assert(false,"Not Implemented")

func can_accept_item():
	return belt_path.can_add_item()

func on_item_accepted():
	belt_path.add_item(pop_accepted_item())

func on_item_ejected():
	belt_path.on_ejected_item()

func copy_to(tile):
	super.copy_to(tile)
	tile.belt_path=belt_path
