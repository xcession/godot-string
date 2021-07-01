extends Node2D


const NumberTile := preload("res://Tile.tscn")

const SPIN_UP_DISTANCE: float = 100.0

signal stopped

export(Array, String) var pictures := [
	preload("res://sprites/0.png"),
	preload("res://sprites/1.png"),
	preload("res://sprites/2.png"),
	preload("res://sprites/3.png"),
	preload("res://sprites/4.png"),
	preload("res://sprites/5.png"),
	preload("res://sprites/6.png"),
	preload("res://sprites/7.png"),
	preload("res://sprites/8.png"),
	preload("res://sprites/0.png"),
]

export(int, 1, 20) var reels := 5
export(int, 1, 20) var tiles_per_reel := 4
# Defines how long the reels are spinning
export(float, 0, 10) var runtime := 1.0
# Defines how fast the reels are spinning
export(float, 0.1, 10) var speed := 5.0
# Defines the start delay between each reel
export(float, 0, 2) var reel_delay := 0.2

# Adjust tile size to viewport
onready var size := get_viewport_rect().size
onready var tile_size := size / Vector2(reels, tiles_per_reel)
# Normalizes the speed for consistency independent of the number of tiles
onready var speed_norm := speed * tiles_per_reel
# Add additional tiles outside the viewport of each reel for smooth animation
# Add it twice for above and below the grid
onready var extra_tiles := int(ceil(SPIN_UP_DISTANCE / tile_size.y) * 2)

# Stores the actual number of tiles
onready var rows := tiles_per_reel + extra_tiles

enum State {OFF, ON, STOPPED}
var state = State.OFF
var result := {}

# Stores Tile instances
const tiles := []
# Stores the top left corner of each grid cell
const grid_pos := []

# 1/speed*runtime*reels times
# Stores the desired number of movements per reel
onready var expected_runs: int = int(runtime * speed_norm)
# Stores the current number of movements per reel
var tiles_moved_per_reel := []
# When force stopped, stores the current number of movements
var runs_stopped := 0
# Store the run independent of how they are archived
var total_runs: int


func _ready():
	# Initializes grid of tiles
	for col in reels:
		grid_pos.append([])
		tiles_moved_per_reel.append(0)
		for row in range(rows):
			# Position extra tiles above and below the viewport
			grid_pos[col].append(Vector2(col, row - 0.5 * extra_tiles) * tile_size)
			_add_tile(col, row)


# Store and initializes a new tile at the given grid cell
func _add_tile(col: int, row: int) -> void:
	tiles.append(NumberTile.instance())
	var tile := get_tile(col, row)
	tile.get_node("Tween").connect("tween_completed", self, "_on_tile_moved")
	tile.set_texture(_randomTexture())
	tile.set_size(tile_size)
	tile.position = grid_pos[col][row]
	tile.set_speed(speed_norm)
	add_child(tile)


# Returns the tile at the given grid cell
func get_tile(col: int, row: int) -> Tile:
	return tiles[(col * rows) + row]


func _randomTexture() -> String:
	return pictures[randi() % pictures.size()]
