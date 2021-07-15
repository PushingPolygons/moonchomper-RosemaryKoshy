extends Node

# Member variables:
var chomper_ps: PackedScene = preload("res://chomper/chomper.tscn")

export var chomper_count: int = 12
export var chomper_distance: float = 600.0 # px

# When Level starts
func _ready() -> void:
	var center: Vector2 = get_viewport().get_visible_rect().size / 2
	spawn_chompers(chomper_count, center, chomper_distance)
	print("Spawned ", chomper_count, " chompers")

func spawn_chompers(count: int, center: Vector2, radius: float) -> void:
	for i in count:
		var chomper: Chomper = chomper_ps.instance()
		chomper.position.x = center.x + radius * cos(2 * PI * i / count)
		chomper.position.y = center.y + radius * sin(2 * PI * i / count)
		chomper.Initialize($Moon)
		self.add_child(chomper)
