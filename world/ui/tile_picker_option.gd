class_name TilePickerOption
extends VBoxContainer

@export var texture:Texture2D
@export var scene:PackedScene

@onready var sprite:TextureRect=$TextureRect
@onready var anim_player:AnimationPlayer=$AnimationPlayer

var has_mouse:bool=false

func _ready() -> void:
	sprite.texture=texture

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		if (event.button_index==MOUSE_BUTTON_LEFT and sprite.get_rect().has_point(get_local_mouse_position())):
			GameState.set_placable_tile(scene)
			anim_player.play("click_tile_picker_option")

func _on_mouse_entered() -> void:
	has_mouse=true
	anim_player.play("hover_over_tile_picker_option")
