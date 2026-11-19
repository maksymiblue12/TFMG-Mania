class_name BeltSplitter
extends ItemInterface

var SCREEN=preload("res://tiles/belts/belt_splitter/belt_splitter_screen.tscn")

static var ITEM_TYPE_TO_ID={
	"any":0,
	"iron":1,
	"coal":2,
}

var avaiable_dirs:Array[bool]=[false,false,false,false]
var filter_dirs:Array[String]=["any","any","any"]
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

func on_interact():
	var s=SCREEN.instantiate()
	s.load_data(filter_dirs[0],filter_dirs[1],filter_dirs[2],self.on_close_screen)
	GameState.ui.show_screen(s)

func on_close_screen(new_item_type_1,new_item_type_2,new_item_type_3):
	filter_dirs=[new_item_type_1,new_item_type_2,new_item_type_3]
	GameState.ui.hide_screen()

func on_item_accepted():
	if (try_set_ejector_item(accepted_item)):
		pop_accepted_item()

func get_ejector_direction():
	next_direction()
	return current_dir

func tile_can_accept(from_dir:GameConstants.DIRECTION):
	var t=square.get_direction_neighbours()[from_dir]
	return t and t.has_tile and t.tile.has_component("item_acceptor") and t.tile.could_accept_item(GameConstants.ITEM_TYPE.NONE,from_dir)

func update_directions():
	for i in GameConstants.DIRECTION.values():
		avaiable_dirs[i]=i!=GameConstants.OPPOSITE_DIRECTION[dir] and i!=current_dir and tile_can_accept(i)

func filter_avaiable_dirs(item:GameConstants.ITEM_TYPE):
	var correct=["any",GameConstants.STRING_TO_ITEM_TYPE.find_key(item)]
	var res=avaiable_dirs.duplicate()
	res[GameConstants.PREVIOUS_DIRECTION[dir]]=filter_dirs[GameConstants.PREVIOUS_DIRECTION[dir]] in correct
	res[dir]=filter_dirs[dir] in correct
	res[GameConstants.NEXT_DIRECTION[dir]]=filter_dirs[GameConstants.NEXT_DIRECTION[dir]] in correct
	return res

func next_direction():
	update_directions()
	if (avaiable_dirs.all(func (a):return !a)):
		current_dir=GameConstants.OPPOSITE_DIRECTION[dir]
		ejector_active=false
		return
	var a_dirs=filter_avaiable_dirs(item_to_eject)
	current_dir=GameConstants.NEXT_DIRECTION[current_dir]
	while (!a_dirs[current_dir]):
		current_dir=GameConstants.NEXT_DIRECTION[current_dir]
	ejector_active=true

func _process(_delta: float) -> void:
	super._process(_delta)
	if (has_accepted_item()):
		on_item_accepted()
	if (!ejector_active):
		next_direction()
