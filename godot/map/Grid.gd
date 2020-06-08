extends Node2D

onready var tilemap_rect = get_parent().get_used_rect()
onready var tilemap_cell_size = get_parent().cell_size
onready var color = Color(0.0, 0.0, 0.75)

func _ready():
	set_process(true)

func _process(_delta):
	update()

func _draw():
	for y in range(0, tilemap_rect.size.y):
		var x1 = 0
		var y1 = y * tilemap_cell_size.y
		var x2 = tilemap_rect.size.x * tilemap_cell_size.x
		var y2 = y * tilemap_cell_size.y
		draw_line(
			Vector2(x1, y1),
			Vector2(x2, y2),
			color)

	for x in range(0, tilemap_rect.size.x):
		var x1 = x * tilemap_cell_size.x
		var y1 = 0
		var x2 = x * tilemap_cell_size.x
		var y2 = tilemap_rect.size.y * tilemap_cell_size.y
		draw_line(
			Vector2(x1, y1),
			Vector2(x2, y2),
			color)
