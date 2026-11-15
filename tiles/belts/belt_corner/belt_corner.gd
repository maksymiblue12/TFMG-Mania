class_name BeltCorner
extends BasicBelt

var flipped:bool=false

func _init() -> void:
	super._init()
	scene=preload("res://tiles/belts/belt_corner/belt_corner.tscn")
	components.append("belt_corner")
	dir=GameConstants.DIRECTION.RIGHT

func get_direction():
	return GameConstants.OPPOSITE_DIRECTION[dir] if flipped else dir

func get_starting_direction():
	return GameConstants.NEXT_DIRECTION[dir]

func get_points_for_path():
	var ps=[]
	var segments=10
	var rx=$Sprite2D.get_rect().size.x
	var ry=$Sprite2D.get_rect().size.y
	var r=$Sprite2D.get_rect().size.x/2
	var start:Vector2
	var offset:float
	if (dir==GameConstants.DIRECTION.RIGHT):
		start=global_position+Vector2((0 if flipped else rx),ry)
		offset=180 if flipped else 270
	elif (dir==GameConstants.DIRECTION.DOWN):
		start=global_position+Vector2(0,(0 if flipped else ry))
		offset=90 if flipped else 180
	elif (dir==GameConstants.DIRECTION.LEFT):
		start=global_position+Vector2((rx if flipped else 0),0)
		offset=0 if flipped else 90
	elif (dir==GameConstants.DIRECTION.UP):
		start=global_position+Vector2(rx,(ry if flipped else 0))
		offset=270 if flipped else 0

	var rn=range(segments) if flipped else range(segments,0,-1)
	for i in rn:
		var a=deg_to_rad(offset+float(i)/segments*90)
		var x=start.x-cos(a)*r
		var y=start.y+sin(a)*r
		ps.append(Vector2(x,y))
	ps.append(get_direction_side(get_direction()))
	return ps

func _ready() -> void:
	super._ready()
	GameState.belt_manager.on_belt_corner_added(self)
	$Sprite2D.flip_v=!flipped
	block_all_acceptor_directions()
	blocked_acceptor_directions[get_starting_direction()]=false

func copy_to(tile):
	super.copy_to(tile)
	tile.flipped=flipped
