extends Node

# Member variables:
var chomper_ps: PackedScene = preload("res://chomper/chomper.tscn")

export var chomper_min: int = 5
export var chomper_max: int = 15
export var chomper_distance: float = 1000.0 # px

# When Level starts
func _ready() -> void:
	randomize()
	var chomper_count = randi() % (chomper_max - chomper_min + 1) + chomper_min
	var center: Vector2 = get_viewport().get_visible_rect().size / 2
	spawn_chompers(chomper_count, center, chomper_distance)
	print("Spawned ", chomper_count, " chompers")

func _process(delta_t: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused

func spawn_chompers(count: int, center: Vector2, radius: float) -> void:
	for i in count:
		var chomper: Chomper = chomper_ps.instance()
		chomper.position.x = center.x + radius * cos(2 * PI * i / count)
		chomper.position.y = center.y + radius * sin(2 * PI * i / count)
		chomper.speed *= randi() % 3 + 1
		chomper.health *= randi() % 3 + 1
		chomper.Initialize($Moon)
		self.add_child(chomper)
