extends Node
class_name Level

# TODO: health packs, gameover & win screens, score & highscore,
#       clock display, level display

const difficulty_max: int = 3
const win_level: int = 11
const sky_textures: Array = [
	preload('res://level/assets/sky-1.jpg'),
	preload('res://level/assets/sky-2.jpg'),
	preload('res://level/assets/sky-3.jpg')
]
const chomper_ps: PackedScene = preload('res://chomper/chomper.tscn')
const menu_ps: PackedScene = preload('res://menu/menu.tscn')
const success = preload('res://level/assets/success.jpg')
const failure = preload('res://level/assets/failure.jpg')
const gameover = preload('res://level/assets/gameover.jpg')

# Member variables:
var chomper_count: int = 0
var difficulty: int = 0  #exceeds difficulty_max for player to win

export var chomper_min: int = 1
export var chomper_max: int = 4
export var chomper_distance: float = 256.0 # px

# When Level starts
func _ready() -> void:
	# avoid multiple menus
	if not len(get_tree().get_nodes_in_group('menu')):
		spawn_menu()
	randomize()
	print('Right click to slow, left click to attack')
	difficulty = 0
	next_level()

func spawn_menu():
	var menu: Menu = menu_ps.instance()
	self.add_child(menu)
	menu.add_to_group('menu')

func start_level():
	print('Start level ', difficulty)
	$Menu/Level.text = 'Level ' + str(difficulty - win_level)
	$Sky.texture = sky_textures[(difficulty - 1) % difficulty_max]
	chomper_count = randi() % (difficulty * (chomper_max - chomper_min) + 1) + difficulty * chomper_min
	spawn_enemies(chomper_count, chomper_distance)
	print('Spawned ', chomper_count, ' chompers')

func _process(_delta_t: float) -> void:
	if Input.is_action_just_pressed('ui_cancel'):
		$Menu.toggle_pause()

func spawn_enemies(count: int, radius: float) -> void:
	var moon_pos: Vector2 = $Moon.get_position()
	for i in count:
		var chomper: Chomper = chomper_ps.instance()
		chomper.speed *= randi() % int(min(ceil(difficulty / 2.0), difficulty_max)) + 1
		chomper.health *= randi() % int(min(ceil(difficulty / 2.0), difficulty_max)) + 1
		chomper.whiplash = randi() % 64 + 1
		if i % 2:
			chomper.position.x = moon_pos.x + radius * sqrt(count) * chomper.speed * chomper.health * cos(2 * PI * i / count) / 108.0
			chomper.position.y = moon_pos.y + radius * sqrt(count) * (chomper.speed + chomper.health) * sin(2 * PI * i / count) / 108.0
		else:
			chomper.position.x = moon_pos.x + radius * sqrt(count) * (chomper.speed + chomper.health) * cos(2 * PI * i / count) / 108.0
			chomper.position.y = moon_pos.y + radius * sqrt(count) * chomper.speed * chomper.health * sin(2 * PI * i / count) / 108.0
		chomper.initialize($Moon)
		self.add_child(chomper)
		chomper.add_to_group('enemies')

func destroy_chomper(how_many: int) -> void:
	chomper_count -= how_many
	if how_many == 1:
		print('Chomper destroyed: ', chomper_count, ' remaining')
	else:
		print(how_many, 'chompers destroyed: ', chomper_count, ' remaining')

func killall(what: String) -> void:
	for child in get_tree().get_nodes_in_group(what):
		child.queue_free()

func next_level() -> void:
	killall('enemies')
	difficulty += 1
	start_level()

func game_over() -> void:
	$Menu/Clock.stopped = true
	killall('enemies')
	if difficulty >= win_level and $Menu.score >= 0:
		print('GAME OVER: SUCCESS')
		$Sky.texture = success
	else:
		print('GAME OVER: FAILURE')
		$Sky.texture = failure
