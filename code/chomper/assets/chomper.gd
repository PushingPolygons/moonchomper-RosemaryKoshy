extends Node2D
class_name Chomper

const defaultspeed: float = 100.0
const chomper_textures: Array = [
	[
		preload("res://chomper/assets/chomper.png"),
		preload("res://chomper/assets/chomper-open.png"),
		preload("res://chomper/assets/chomper-xopen.png")
	],
	[
		preload("res://chomper/assets/chomper-2.png"),
		preload("res://chomper/assets/chomper-open-2.png"),
		preload("res://chomper/assets/chomper-xopen-2.png")],
	[
		preload("res://chomper/assets/chomper-3.png"),
		preload("res://chomper/assets/chomper-open-3.png"),
		preload("res://chomper/assets/chomper-xopen-3.png")
	]
]

# Member variables:
var _moon: Moon = null
var health: int = 1
var speed: float = defaultspeed

func initialize(moon: Moon):
	update_texture()
	self._moon = moon

# Called every frame. delta_t is the time since the previous frame
func _process(delta_t: float):
	self.look_at(_moon.position)
	self.translate(speed * delta_t * self.position.direction_to(_moon.position))

func _on_Area2D_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	# TODO: health packs
	if event.is_action_pressed("left_click"):
		self.health -= 1
		update_texture()
		get_tree().get_root().get_node("Level/Menu").update_score(60)
		if self.health <= 0:
			self.queue_free() # Destroy chomper.
			get_parent().destroy_chomper(1)
			if get_parent().chomper_count < 1:
				get_parent().next_level()
	if event.is_action_pressed("right_click"):
		self.speed /= 2.0
		update_texture()

func update_texture():
	var relative_speed: float = round(speed / defaultspeed) - 1
	if relative_speed < 0:
		relative_speed = 0
	$Area2D/Sprite.texture = chomper_textures[health - 1][relative_speed]
