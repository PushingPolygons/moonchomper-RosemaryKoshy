extends Node2D
class_name Moon

# Member variables:
var moon_textures: Array = [preload("res://moon/assets/moon-health-0.png"),
							preload("res://moon/assets/moon-health-1.png"),
							preload("res://moon/assets/moon-health-2.png"),
							preload("res://moon/assets/moon-health-3.png"),
							preload("res://moon/assets/moon-health-4.png"),
							preload("res://moon/assets/moon-health-5.png")]
var health: int = 0
export var speed: float = 512.0 # px/s

# When Moon enters scene
func _ready() -> void:
	self.set_position(get_viewport().get_visible_rect().size / 2)
	health = len(moon_textures) - 1
	update_health(0)

# Called every frame
# delta_t is the time since the previous frame
func _process(delta_t: float) -> void:
	if Input.is_action_pressed("ui_up"):
		self.translate(Vector2.UP * speed * delta_t)
	if Input.is_action_pressed("ui_down"):
		self.translate(Vector2.DOWN * speed * delta_t)
	if Input.is_action_pressed("ui_left"):
		self.translate(Vector2.LEFT * speed * delta_t)
	if Input.is_action_pressed("ui_right"):
		self.translate(Vector2.RIGHT * speed * delta_t)

# Moon collision
func _on_Area2D_area_entered(area: Area2D) -> void:
	# attack
	update_health(-1)
	# notify
	get_parent().destroy_chomper(1)
	# die
	area.queue_free()
	if get_parent().chomper_count < 1:
		get_parent().next_level()

func update_health(delta_h: int) -> void:
	health += delta_h
	if health <= 0:
		$Area2D/Sprite.texture = moon_textures[0]
		get_parent().game_over('FAILURE!')
	else:
		print("Moon Health: ", health)
		$Area2D/Sprite.texture = moon_textures[health]
