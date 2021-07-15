extends Node2D
class_name Moon

# Member variables:
var health: int = 5
export var speed: float = 512.0 # px/s

# When Moon enters scene
func _ready() -> void:
	update_health(0)

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


func _on_Area2D_area_entered(area: Area2D):
	area.queue_free()
	update_health(-get_parent().get_node("Chomper").attack)
	pass # Replace with function body.

func update_health(delta_h: int):
	health += delta_h
	print("Moon Health: ", health)
	if health <= 0:
		get_tree().quit()
