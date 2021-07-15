extends Node

# Member variables:
var chomper_ps: PackedScene = preload("res://chomper/chomper.tscn")
var chomper_count: int = 6;
var chomper_distance: float = 512.0;  # in pixels

# When Level starts
func _ready() -> void:
	var center: Vector2 = get_viewport().get_visible_rect().size / 2
	SpawnChompers(chomper_count, center, chomper_distance)
	print("Spawned ", chomper_count, " chompers")

func SpawnChompers(count: int, center: Vector2, radius: float) -> void:
	for i in count:
		var chomper: Chomper = chomper_ps.instance()
		chomper.position.x = center.x + radius * cos(2 * PI * i / count)
		chomper.position.y = center.y + radius * sin(2 * PI * i / count)
		chomper.Initialize($Moon)
		self.add_child(chomper)
