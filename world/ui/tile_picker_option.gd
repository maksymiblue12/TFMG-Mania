class_name TilePickerOption
extends VBoxContainer

@export var texture:Texture2D
@export var scene:PackedScene
@export var function_to_call_name:String

@onready var sprite:TextureRect=$TextureRect
@onready var anim_player:AnimationPlayer=$AnimationPlayer

func _ready() -> void:
	sprite.texture=texture

func _input(event: InputEvent) -> void:
	if (!is_visible_in_tree() or GameState.showing_screen): return
	if (event is InputEventMouseButton):
		if (event.button_index==MOUSE_BUTTON_LEFT and sprite.get_rect().has_point(get_local_mouse_position())):
			GameState.set_placable_tile(scene)
			if (!function_to_call_name.is_empty()):
				GameState.tile_to_place.call(function_to_call_name)
			GameState.ui.tile_preview.update_sprite(texture,[sprite.flip_h,sprite.flip_v],sprite.material)
			anim_player.play("click_tile_picker_option")

func _on_mouse_entered() -> void:
	anim_player.play("hover_over_tile_picker_option")
