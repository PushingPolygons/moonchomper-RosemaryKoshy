extends Node2D
class_name Moon

const speed: float = 512.0 # px/s
const moon_textures: Array = [
	preload('res://moon/assets/moon-health-0.png'),
	preload('res://moon/assets/moon-health-1.png'),
	preload('res://moon/assets/moon-health-2.png'),
	preload('res://moon/assets/moon-health-3.png'),
	preload('res://moon/assets/moon-health-4.png'),
	preload('res://moon/assets/moon-health-5.png')
]

# Member variables:
var health: int = 0
var x_max: float = 0.0
var y_max: float = 0.0

# When Moon enters scene
func _ready():
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	self.set_position(viewport_size / 2)
	x_max = viewport_size.x
	print('viewport x: ', x_max)
	y_max = viewport_size.y
	print('viewport y: ', y_max)
	health = len(moon_textures) - 1
	update_health(0)

# Called every frame
# delta_t is the time since the previous frame
func _process(delta_t: float):
	if Input.is_action_pressed('ui_up') and self.get_position().y > 0:
		self.translate(Vector2.UP * speed * delta_t)
	if Input.is_action_pressed('ui_down') and self.get_position().y < y_max:
		self.translate(Vector2.DOWN * speed * delta_t)
	if Input.is_action_pressed('ui_left') and self.get_position().x > 0:
		self.translate(Vector2.LEFT * speed * delta_t)
	if Input.is_action_pressed('ui_right') and self.get_position().x < x_max:
		self.translate(Vector2.RIGHT * speed * delta_t)

# Moon collision
func _on_Area2D_area_entered(area: Area2D):
	# attack
	update_health(-1)
	# die
	area.queue_free()
	# notify
	get_parent().destroy_chomper(1)
	# go to next_level if no chomper_count and moon has health
	if get_parent().chomper_count < 1 and health > 0:
		get_parent().next_level()

func update_health(delta_h: int):
	health += delta_h
	if health <= 0:
		$Area2D/Sprite.texture = moon_textures[0]
		get_parent().game_over()
	else:
		print('Moon Health: ', health)
		$Area2D/Sprite.texture = moon_textures[health]
