extends Node2D
class_name Chomper

# Member variables:
var _moon: Moon = null
var health: int = 1
var attack: int = 1
var speed: float = 55.072679252057455

func Initialize(moon: Moon):
	self._moon = moon

# Called every frame. delta_t is the time since the previous frame
func _process(delta_t: float) -> void:
	# self.position += Vector2(48, 27) * delta_t
	self.look_at(_moon.position)
	self.translate(self.position.direction_to(_moon.position))

func _on_Area2D_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		self.health -= 1
		if self.health <= 0:
			self.queue_free() # Destroy chomper.
			print("Chomper destroyed")
