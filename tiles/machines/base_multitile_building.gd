class_name BaseMultiTileBuilding
extends Building

var size:Vector2
var special_tiles:Dictionary
var controller_position:Vector2=Vector2(0,0)

var special_tile_lookup:Dictionary={}

func _init() -> void:
	super._init()
	components.append("multitile")

func can_accept_item(_tile_name:String,_item_type:GameConstants.ITEM_TYPE,_from_dir:GameConstants.DIRECTION):
	return true

func _ready() -> void:
	super._ready()
	sprite.position=size*GameConstants.SQUARE_SIZE/2
	var special={}
	for k in special_tiles.keys():
		var v=special_tiles[k]
		special[v["position"]]={"name":k,"type":v["type"]}
	var sq=square.get_square_relative(controller_position)
	if (sq):
		sq.set_tile(self,true)
	for x in range(size.x):
		for y in range(size.y):
			var offset=Vector2(x,y)-controller_position
			if (offset==Vector2.ZERO): continue
			sq=square.get_square_relative(offset)
			if (!sq): continue
			var t=MultiTileEmpty.new().get_copy()
			if (Vector2(x,y) in special):
				var dt=special[Vector2(x,y)]
				if (dt["type"]=="input"):
					t=MultiTileInput.new().get_copy()
					special_tile_lookup[dt["name"]]=t
				elif (dt["type"]=="output"):
					t=MultiTileOutput.new().get_copy()
					special_tile_lookup[dt["name"]]=t
				t.special_name=dt["name"]
			t.controller=self
			t.dir=dir
			sq.set_tile(t)
