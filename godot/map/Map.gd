extends Node2D

onready var player = $ShipSpain
onready var sea_map = $SeaMap
onready var terrain_map = $TerrainMap
onready var camera = $Camera2D
var zoom_factor = 2
var player_cell = Vector2(1, 1)
var map_rect: Rect2

func _ready():
	get_tree().get_root().connect("size_changed", self, "_update_zoom")
	_update_zoom()

func _update_player_pos():
	player.position = sea_map.map_to_world(player_cell)
	player.position += Vector2(16, 16)

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed():
		var click_pos = get_global_mouse_position()
		var map_pos = sea_map.world_to_map(click_pos)
		print("Click pos: ", click_pos)
		print("Map pos: ", map_pos)
		if terrain_map.get_cellv(map_pos) == -1:
			player_cell = map_pos
			_update_player_pos()

func _process(_delta):
	var offset = Vector2(0, 0)
	if Input.is_action_pressed("camera_scroll_left"):
		offset.x -= 8
	elif Input.is_action_pressed("camera_scroll_right"):
		offset.x += 8

	if Input.is_action_pressed("camera_scroll_up"):
		offset.y -= 8
	elif Input.is_action_pressed("camera_scroll_down"):
		offset.y += 8

	offset.x = clamp(camera.offset.x + offset.x,
			map_rect.position.x, map_rect.end.x)
	offset.y = clamp(camera.offset.y + offset.y,
			map_rect.position.y, map_rect.end.y)
	camera.offset = offset

func _update_zoom():
	camera.zoom = Vector2(1.0 / zoom_factor, 1.0 / zoom_factor)
	map_rect = Rect2(0, 0,
		sea_map.get_used_rect().end.x * sea_map.cell_size.x - get_viewport_rect().size.x / zoom_factor,
		sea_map.get_used_rect().end.y * sea_map.cell_size.y - get_viewport_rect().size.y / zoom_factor)
	_update_player_pos()

func _on_zoom_in():
	if zoom_factor < 4:
		zoom_factor += 1
		_update_zoom()


func _on_zoom_out():
	if zoom_factor > 1:
		zoom_factor -= 1
		_update_zoom()
