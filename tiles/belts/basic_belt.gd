class_name BasicBelt
extends ItemInterface

var belt_path:BeltPath

func _init() -> void:
	super._init()
	components.append("basic_belt")

func _ready() -> void:
	super._ready()
	blocked_acceptor_directions[get_direction()]=true

func calculate_animation_speed(item_speed:float):
	var anim_speed:float=item_speed/sprite.texture.get_size().y
	(sprite.material as ShaderMaterial).set_shader_parameter("speed",anim_speed)

func get_points_for_path():
	assert(false,"Not Implemented")

func can_accept_item(_item_type:GameConstants.ITEM_TYPE,_from_dir:GameConstants.DIRECTION):
	return belt_path.can_add_item()

func on_item_accepted():
	belt_path.add_item(pop_accepted_item())

func on_item_ejected():
	belt_path.on_ejected_item()

func copy_to(tile):
	super.copy_to(tile)
	tile.belt_path=belt_path
