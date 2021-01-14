extends Node2D

var TILE_SIZE = 32

onready var map = get_node('../Navigation/Terrain')

func _process(delta):
	var p = map.world_to_map(get_global_mouse_position())
	$Selector.position = p * TILE_SIZE / 2 + Vector2(TILE_SIZE/4, TILE_SIZE/4)

func get_selected_tile_center() -> Vector2:
	return $Selector.position
