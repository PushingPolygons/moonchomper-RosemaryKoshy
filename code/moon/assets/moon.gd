extends Node2D
class_name Moon

onready var moon_1: Texture = preload("res://moon/assets/moon-health-1.png")
onready var moon_2: Texture = preload("res://moon/assets/moon-health-2.png")
onready var moon_3: Texture = preload("res://moon/assets/moon-health-3.png")
onready var moon_4: Texture = preload("res://moon/assets/moon-health-4.png")
onready var moon_5: Texture = preload("res://moon/assets/moon-health-5.png")

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
		print("FAILURE!")
		get_tree().quit()
		# TODO: display game over menu
	match health:
		1:
			$Area2D/Sprite.texture = moon_1
		2:
			$Area2D/Sprite.texture = moon_2
		3:
			$Area2D/Sprite.texture = moon_3
		4:
			$Area2D/Sprite.texture = moon_4
		5:
			$Area2D/Sprite.texture = moon_5
