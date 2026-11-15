class_name BaseMultiTileBuilding
extends Building

@onready var sprite:Sprite2D=$Sprite2D

var scene:PackedScene
var components:PackedStringArray=PackedStringArray()

var square:Square
var size:Vector2
var special_tiles:Dictionary
var controller_position:Vector2=Vector2(0,0)

var special_tile_lookup:Dictionary={}

func _init() -> void:
	components.append("multitile")

func _ready() -> void:
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
			var t=ItemBlackHole.new().get_copy()
			if (Vector2(x,y) in special):
				var dt=special[Vector2(x,y)]
				if (dt["type"]=="input"):
					t=MultiTileInput.new().get_copy()
					special_tile_lookup[dt["name"]]=t
				elif (dt["type"]=="output"):
					t=MultiTileOutput.new().get_copy()
					special_tile_lookup[dt["name"]]=t
			sq.set_tile(t)

func has_component(c:String):
	return components.has(c)

func copy_to(tile):
	tile.size=size

func get_copy():
	var b=scene.instantiate()
	copy_to(b)
	return b

func _process(_delta: float) -> void:
	pass
