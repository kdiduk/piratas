extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player = $Galeon
onready var map = $TileMap
onready var camera = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed():
		var next = map.world_to_map(event.position + camera.offset)
		if map.get_cellv(next) == 1:
			player.position = map.map_to_world(next)

func _process(delta):
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
