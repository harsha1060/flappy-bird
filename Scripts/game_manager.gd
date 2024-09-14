extends Node

@onready var bird: = $"../Bird" as Bird
@onready var pipe_spawner: PipeSpawner = $"../pipe_spawner" 
@onready var ground: Area2D = $"../Ground" as Ground
@onready var background: Sprite2D = $"../background"
@onready var fade: Fade = $"../Fade" as Fade
@onready var ui: CanvasLayer = $"../UI" as UI

var points = 0

func _ready() -> void:
	bird.game_started.connect(on_game_started)
	ground.crashed.connect(end_game)
	pipe_spawner.bird_crashed.connect(end_game)
	pipe_spawner.point_scored.connect(on_point_scored)
	
func on_game_started():
	pipe_spawner._start_spawning_pipes()

func end_game():
	fade.play()
	ground.stop()
	bird.stop()
	pipe_spawner.stop()
	background.stop()
	ui.on_game_over()

func on_point_scored():
	points += 1
	ui.update_points(points)
	
	
	
