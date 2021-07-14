extends Node

# Member variables:
var chomper_ps: PackedScene = preload("res://Chomper/Chomper.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var chomper_count: int = 4;
	SpawnChompersInCircle(chomper_count, 256)
	print("Spawned ", chomper_count, " chompers")

func SpawnChompersInCircle(chomper_count: int, radius: float) -> void:
	var center: Vector2 = get_viewport().get_visible_rect().size / 2
	
	for i in chomper_count:
		var chomper: Chomper = chomper_ps.instance()
		chomper.position.x = center.x + radius * cos(2 * PI * i / chomper_count)
		chomper.position.y = center.y + radius * sin(2 * PI * i / chomper_count)
		self.add_child(chomper)
