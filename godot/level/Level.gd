extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player = $TileMap/Galeon
onready var map = $TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed():
		var next = map.world_to_map(event.position)
		player.position = map.map_to_world(next)

