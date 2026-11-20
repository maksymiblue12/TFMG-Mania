extends Node

var SQUARE_SIZE=Vector2(100,100)

enum DIRECTION {LEFT,UP,RIGHT,DOWN}
var OPPOSITE_DIRECTION={
	DIRECTION.LEFT:DIRECTION.RIGHT,
	DIRECTION.UP:DIRECTION.DOWN,
	DIRECTION.RIGHT:DIRECTION.LEFT,
	DIRECTION.DOWN:DIRECTION.UP
}
var DIRECTION_TO_VECTOR={
	DIRECTION.LEFT:Vector2.LEFT,
	DIRECTION.UP:Vector2.DOWN,
	DIRECTION.RIGHT:Vector2.RIGHT,
	DIRECTION.DOWN:Vector2.UP
}
var DIRECTION_TO_ROTATION={
	DIRECTION.LEFT:270,
	DIRECTION.UP:0,
	DIRECTION.RIGHT:90,
	DIRECTION.DOWN:180
}
var PREVIOUS_DIRECTION={
	DIRECTION.LEFT:DIRECTION.DOWN,
	DIRECTION.UP:DIRECTION.LEFT,
	DIRECTION.RIGHT:DIRECTION.UP,
	DIRECTION.DOWN:DIRECTION.RIGHT
}
var NEXT_DIRECTION={
	DIRECTION.LEFT:DIRECTION.UP,
	DIRECTION.UP:DIRECTION.RIGHT,
	DIRECTION.RIGHT:DIRECTION.DOWN,
	DIRECTION.DOWN:DIRECTION.LEFT
}

enum ITEM_TYPE {NONE,raw_iron,iron,raw_copper,copper,raw_gold,gold,coal}
var ITEM_TYPE_TO_ID={
	ITEM_TYPE.iron:0,
	ITEM_TYPE.raw_iron:1,
	ITEM_TYPE.copper:2,
	ITEM_TYPE.raw_copper:3,
	ITEM_TYPE.gold:4,
	ITEM_TYPE.raw_gold:5,
	ITEM_TYPE.coal:6,
}
var STRING_TO_ITEM_TYPE={
	"none":ITEM_TYPE.NONE,
	"iron":ITEM_TYPE.iron,
	"raw_iron":ITEM_TYPE.raw_iron,
	"copper":ITEM_TYPE.copper,
	"raw_copper":ITEM_TYPE.raw_copper,
	"gold":ITEM_TYPE.gold,
	"raw_gold":ITEM_TYPE.raw_gold,
	"coal":ITEM_TYPE.coal,
}
var ITEM_TYPE_TO_TEXTURE={
	ITEM_TYPE.NONE:preload("res://assets/textures/items/none.png"),
	ITEM_TYPE.iron:preload("res://assets/textures/items/iron.png"),
	ITEM_TYPE.raw_iron:preload("res://assets/textures/items/raw_iron.png"),
	ITEM_TYPE.copper:preload("res://assets/textures/items/copper.png"),
	ITEM_TYPE.raw_copper:preload("res://assets/textures/items/raw_copper.png"),
	ITEM_TYPE.gold:preload("res://assets/textures/items/gold.png"),
	ITEM_TYPE.raw_gold:preload("res://assets/textures/items/raw_gold.png"),
	ITEM_TYPE.coal:preload("res://assets/textures/items/coal.png"),
}

enum TOOL_TYPE {interact,place,destroy}
