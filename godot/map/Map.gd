extends Node2D

onready var player = $ShipSpain
onready var sea_map = $SeaMap
onready var terrain_map = $TerrainMap
onready var camera = $Camera2D
var zoom_factor = 2
var player_cell = Vector2(1, 1)


func _ready():
	_update_zoom()

func _update_player_pos():
	player.position = sea_map.map_to_world(player_cell) * zoom_factor
	player.position += Vector2(zoom_factor * 16, zoom_factor * 16)

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed():
		var click_pos = get_global_mouse_position() / zoom_factor
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
			-120, 2048)
	offset.y = clamp(camera.offset.y + offset.y,
			-40, 1440)
	camera.offset = offset

func _update_zoom():
	sea_map.scale = Vector2(zoom_factor, zoom_factor)
	terrain_map.scale = Vector2(zoom_factor, zoom_factor)
	player.scale = Vector2(zoom_factor, zoom_factor)
	_update_player_pos()

func _on_zoom_in():
	if zoom_factor < 4:
		zoom_factor += 1
		_update_zoom()


func _on_zoom_out():
	if zoom_factor > 1:
		zoom_factor -= 1
		_update_zoom()
