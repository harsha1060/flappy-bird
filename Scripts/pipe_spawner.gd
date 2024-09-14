extends Node


class_name PipeSpawner

signal bird_crashed
signal point_scored


var pipes = preload("res://Scenes/pipes.tscn")

@export var pipe_speed = -240
@onready var spawn_timer: Timer = $spawn_timer

func _ready() -> void:
	spawn_timer.start()

func _start_spawning_pipes():
	spawn_timer.timeout.connect(spawn_pipe)

func spawn_pipe():
	var pipe = pipes.instantiate() as Pipes
	add_child(pipe)
	
	var viewport_rect = get_viewport().get_visible_rect()
	pipe.global_position.x = viewport_rect.end.x
	
	var half_height = viewport_rect.size.y / 2
	pipe.position.y = randf_range(viewport_rect.size.y * 0.20 - half_height, 
							  viewport_rect.size.y * 0.60 - half_height)

	
	pipe.bird_entered.connect(on_bird_entered)
	pipe.point_scored.connect(on_point_scored)
	pipe.set_speed(pipe_speed)
	
func on_bird_entered():
	bird_crashed.emit()
	stop()
	
func stop():
	spawn_timer.stop()
	for pipe in get_children().filter(func (child): return child is Pipes):
		(pipe as Pipes).speed = 0

func on_point_scored():
	point_scored.emit()
	
