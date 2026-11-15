class_name UI
extends CanvasLayer

@onready var anim_player:AnimationPlayer=$MarginContainer/HBoxContainer/AnimationPlayer

@onready var tile_preview:TilePreview=$MarginContainer/VBoxContainer/HBoxContainer/TilePreview

var tile_picker_open:bool=false

func _ready() -> void:
	for t in $MarginContainer/HBoxContainer/Panel/MarginContainer/TabContainer/Belt/VBoxContainer.get_children():
		t.ui=self

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("open_tile_picker")):
		if (anim_player.is_playing()): return
		if (tile_picker_open):
			anim_player.play("tile_picker_close")
		else:
			anim_player.play("tile_picker_open")

func on_tile_picker_opened():
	tile_picker_open=true

func on_tile_picker_closed():
	tile_picker_open=false
