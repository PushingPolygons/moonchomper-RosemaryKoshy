extends Node

# Member variables:
var chomper_ps: PackedScene = preload("res://chomper/chomper.tscn")
var chomper_count: int = 0
var difficulty: int = 0
var difficulty_max: int = 3

var sky_textures: Array = [preload("res://level/assets/sky-1.jpg"),
						   preload("res://level/assets/sky-2.jpg"),
						   preload("res://level/assets/sky-3.jpg")]

export var chomper_min: int = 2
export var chomper_max: int = 5
export var chomper_distance: float = 1000.0 # px

# When Level starts
func _ready() -> void:
	randomize()
	print('Right click to slow, left click to attack')
	next_level()

func start_level():
	print('Start level ', difficulty, ' of ', difficulty_max)
	$Sky.texture = sky_textures[difficulty - 1]
	chomper_count = randi() % (difficulty * (chomper_max - chomper_min) + 1) + difficulty * chomper_min
	var center: Vector2 = get_viewport().get_visible_rect().size / 2
	spawn_chompers(chomper_count, center, chomper_distance)
	print("Spawned ", chomper_count, " chompers")

func _process(_delta_t: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused

func spawn_chompers(count: int, center: Vector2, radius: float) -> void:
	for i in count:
		var chomper: Chomper = chomper_ps.instance()
		chomper.position.x = center.x + radius * cos(2 * PI * i / count)
		chomper.position.y = center.y + radius * sin(2 * PI * i / count)
		chomper.speed *= randi() % difficulty + 1
		chomper.health *= randi() % difficulty + 1
		chomper.initialize($Moon)
		self.add_child(chomper)

func destroy_chomper(how_many: int) -> void:
	chomper_count -= how_many
	if how_many == 1:
		print("Chomper destroyed: ", chomper_count, " remaining")
	else:
		print(how_many, "chompers destroyed: ", chomper_count, " remaining")

func next_level() -> void:
	difficulty += 1
	if difficulty > difficulty_max:
		game_over('SUCCESS!')
	else:
		start_level()

func game_over(message: String) -> void:
		print('GAME OVER: ', message)
		get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
