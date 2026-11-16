class_name BaseBuilding
extends Building

func get_center():
	return global_position+sprite.get_rect().size/2

func get_direction_side(dirc):
	return global_position+sprite.get_rect().size/2+sprite.get_rect().size/2*GameConstants.DIRECTION_TO_VECTOR[dirc]*Vector2(1,-1)
