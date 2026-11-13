class_name Belt
extends BasicBelt

func _init() -> void:
	super._init()
	scene=preload("res://tiles/belt/belt.tscn")
	components.append("belt")

func get_points_for_path():
	return [get_center(),get_direction_side(dir)]

func _ready() -> void:
	super._ready()
	GameState.belt_manager.on_belt_added(self)
