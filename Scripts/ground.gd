extends Area2D

class_name Ground

@onready var ground: Area2D = $"."
@onready var bird: CharacterBody2D = $"../Bird"
@onready var background: Sprite2D = $"../background"

signal crashed
const GROUND_SPEED : int = 4
var ground_scroll
var screen_size : Vector2
var hit = false

func _ready() -> void:
	screen_size = get_viewport().size
	ground_scroll = 0

func _process(_delta: float) -> void:
	if !hit :
		ground_scroll += GROUND_SPEED
		if ground_scroll > screen_size.x:
			ground_scroll = 0
		ground.position.x = -ground_scroll

func _on_body_entered(_body: Node2D) -> void:
	crashed.emit()
	hit = true
	bird.stop()
	background.stop()

func stop():
	hit = true
