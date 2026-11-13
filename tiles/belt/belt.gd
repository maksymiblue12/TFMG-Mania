class_name Belt
extends ItemInterface

var belt_path:BeltPath

func _init() -> void:
	super._init()
	scene=preload("res://tiles/belt/belt.tscn")
	components.append("belt")

func can_accept_item():
	return belt_path.can_add_item()

func on_item_accepted():
	belt_path.add_item(pop_accepted_item())

func on_item_ejected():
	belt_path.on_ejected_item()

func _ready() -> void:
	super._ready()
	GameState.belt_manager.on_belt_added(self)

func copy_to(tile):
	super.copy_to(tile)
	tile.belt_path=belt_path
