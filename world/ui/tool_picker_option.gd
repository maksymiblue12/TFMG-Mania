class_name ToolPickerOption
extends Button

@export var tool_name:String
@export var tool_type:GameConstants.TOOL_TYPE

func _ready() -> void:
	text=tool_name

func _on_pressed() -> void:
	if (GameState.showing_screen): return
	GameState.tool=tool_type
