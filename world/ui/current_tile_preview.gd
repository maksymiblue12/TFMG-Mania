class_name TilePreview
extends Control

@onready var texture_rect:TextureRect=$TextureRect

func _ready() -> void:
	GameState.rotated_tile_to_place.connect(self.update_rotation)

func update_rotation():
	texture_rect.rotation_degrees=GameConstants.DIRECTION_TO_ROTATION[GameState.tile_to_place.dir]
	if (GameState.tile_to_place.has_component("belt_corner")):
		texture_rect.rotation_degrees-=90

func update_sprite(texture:Texture2D,flip:Array[bool],_material:Material):
	update_rotation()
	texture_rect.texture=texture
	texture_rect.flip_h=flip[0]
	texture_rect.flip_v=flip[1]
	if (_material):
		texture_rect.material=_material.duplicate()
	else:
		texture_rect.material=null
