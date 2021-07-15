extends Node2D
class_name Moon

# Member variables:
var health: int = 4
export var speed: float = 100.0 # px/s

# When Moon enters scene
func _ready() -> void:
	health = 4
	print("Moon Health: ", health)

# Called every frame. delta_t is the time since the previous frame
func _process(delta_t: float) -> void:
	if Input.is_action_pressed("move_up"):
		self.translate(Vector2.UP * speed * delta_t)
	if Input.is_action_pressed("move_down"):
		self.translate(Vector2.DOWN * speed * delta_t)
	if Input.is_action_pressed("move_left"):
		self.translate(Vector2.LEFT * speed * delta_t)
	if Input.is_action_pressed("move_right"):
		self.translate(Vector2.RIGHT * speed * delta_t)
