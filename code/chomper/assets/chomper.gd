extends Node2D
class_name Chomper

const defaultspeed: float = 100.0

# Member variables:
var _moon: Moon = null
var health: int = 1
var attack: int = 1
var speed: float = defaultspeed

var chomper_textures: Array = [[preload("res://chomper/assets/chomper.png"),
								preload("res://chomper/assets/chomper-open.png"),
								preload("res://chomper/assets/chomper-xopen.png")],
							   [preload("res://chomper/assets/chomper-2.png"),
								preload("res://chomper/assets/chomper-open-2.png"),
								preload("res://chomper/assets/chomper-xopen-2.png")],
							   [preload("res://chomper/assets/chomper-3.png"),
								preload("res://chomper/assets/chomper-open-3.png"),
								preload("res://chomper/assets/chomper-xopen-3.png")]]

func Initialize(moon: Moon):
	update_texture()
	self._moon = moon

# Called every frame. delta_t is the time since the previous frame
func _process(delta_t: float) -> void:
	# self.position += Vector2(48, 27) * delta_t
	self.look_at(_moon.position)
	self.translate(speed * delta_t * self.position.direction_to(_moon.position))

func _on_Area2D_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		self.health -= 1
		update_texture()
		if self.health <= 0:
			self.queue_free() # Destroy chomper.
			print("Chomper destroyed")
	if event.is_action_pressed("right_click"):
		self.speed /= 2.0
		update_texture()

func update_texture() -> void:
	$Area2D/Sprite.texture = chomper_textures[health - 1][round(speed / defaultspeed) -1 if round(speed / defaultspeed) - 1 > 0 else 0]
