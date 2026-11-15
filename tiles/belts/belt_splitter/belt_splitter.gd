class_name BeltSplitter
extends ItemInterface

var avaiable_dirs:Array[bool]=[false,false,false,false]
var current_dir:GameConstants.DIRECTION=GameConstants.OPPOSITE_DIRECTION[dir]

func _init() -> void:
	super._init()
	scene=preload("res://tiles/belts/belt_splitter/belt_splitter.tscn")
	components.append("belt_splitter")

func _ready() -> void:
	super._ready()
	block_all_acceptor_directions()
	blocked_acceptor_directions[GameConstants.OPPOSITE_DIRECTION[dir]]=false
	next_direction()

func on_item_accepted():
	if (try_set_ejector_item(accepted_item)):
		pop_accepted_item()

func get_ejector_direction():
	if (current_dir==GameConstants.OPPOSITE_DIRECTION[dir]):
		next_direction()
	return current_dir

func on_item_ejected():
	next_direction()

func tile_can_accept(from_dir:GameConstants.DIRECTION):
	var t=square.get_direction_neighbours()[from_dir]
	return t and t.has_tile and t.tile.has_component("item_acceptor") and t.tile.could_accept_item(from_dir)

func update_directions():
	for i in GameConstants.DIRECTION.values():
		avaiable_dirs[i]=i!=GameConstants.OPPOSITE_DIRECTION[dir] and i!=current_dir and tile_can_accept(i)

func next_direction():
	update_directions()
	if (avaiable_dirs.all(func (a):return !a)):
		current_dir=GameConstants.OPPOSITE_DIRECTION[dir]
		ejector_active=false
		return
	current_dir=GameConstants.NEXT_DIRECTION[current_dir]
	while (!avaiable_dirs[current_dir]):
		current_dir=GameConstants.NEXT_DIRECTION[current_dir]
	ejector_active=true

func _process(_delta: float) -> void:
	super._process(_delta)
	if (has_accepted_item()):
		on_item_accepted()
	if (!ejector_active):
		next_direction()
