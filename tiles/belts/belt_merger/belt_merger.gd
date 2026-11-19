class_name BeltMerger
extends ItemInterface

var avaiable_dirs:Array[bool]=[false,false,false,false]
var current_dir:GameConstants.DIRECTION=dir

func _init() -> void:
	super._init()
	scene=preload("res://tiles/belts/belt_merger/belt_merger.tscn")
	components.append("belt_merger")

func _ready() -> void:
	super._ready()
	next_direction()

func can_accept_item(_item_type:GameConstants.ITEM_TYPE,from_dir:GameConstants.DIRECTION):
	if (current_dir==dir):
		next_direction()
	return current_dir==GameConstants.OPPOSITE_DIRECTION[from_dir]

func on_item_accepted():
	if (try_set_ejector_item(accepted_item)):
		pop_accepted_item()
		next_direction()

func wants_to_push(from_dir:GameConstants.DIRECTION):
	var t=square.get_direction_neighbours()[from_dir]
	return t and t.has_tile and t.tile.has_component("item_ejector") and t.tile.wants_to_eject()

func update_directions():
	for i in GameConstants.DIRECTION.values():
		avaiable_dirs[i]=i!=dir and i!=current_dir and wants_to_push(i)

func next_direction():
	update_directions()
	if (avaiable_dirs.all(func (a):return !a)):
		current_dir=dir
		return
	current_dir=GameConstants.NEXT_DIRECTION[current_dir]
	while (!avaiable_dirs[current_dir]):
		current_dir=GameConstants.NEXT_DIRECTION[current_dir]

func _process(_delta: float) -> void:
	super._process(_delta)
	if (has_accepted_item()):
		on_item_accepted()
