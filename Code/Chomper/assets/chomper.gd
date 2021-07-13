extends Node2D
class_name Chomper

# Member variables:
var moon: Moon = null
var chomp_power: int = 1

# Called every frame. 'delta_time' is the elapsed time since the previous frame.
func _process(delta_time: float) -> void:
	self.position += Vector2(48, 27) * delta_time

func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		self.queue_free() # Destroy chomper.
		print("Chomper destroyed")
