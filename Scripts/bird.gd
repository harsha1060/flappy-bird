extends CharacterBody2D

class_name Bird

signal game_started

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ground: Area2D = $"../Ground"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const GRAVITY = 1000
const JUMP_VELOCITY = -350.0
const MAX_ROTATION = 90.0  # Maximum rotation in degrees
const ROTATION_SPEED_FACTOR = 0.15  # Factor to control rotation speed
var is_started = false
var hit = false

func _ready() -> void:
	if !is_started:
		animation_player.play("idle")

func _physics_process(delta: float) -> void:
	if !hit :
		animated_sprite.play("Fly")
		
		if Input.is_action_just_pressed("Jump"):
			if !is_started:
				game_started.emit()
				is_started = true
				animation_player.stop()
			jump()
		
		if is_started: # Add gravity.
			velocity.y += GRAVITY * delta
		# Clamp the bird's position within the viewport height
		position.y = clamp(position.y, 0, get_viewport_rect().size.y)
		# Update rotation based on falling speed.
		update_rotation()

		# Move the player.
		move_and_slide()

func update_rotation() -> void:
	# Calculate rotation based on the falling velocity.
	if velocity.y > -100:  # Falling
		# Rotate based on velocity but clamp it to a maximum of 90 degrees.
		rotation_degrees = clamp(velocity.y * ROTATION_SPEED_FACTOR, -20, MAX_ROTATION)
	else:
		# Reset rotation when jumping or rising
		rotation_degrees = -20.0

func jump(): # Handle jump.
	velocity.y = JUMP_VELOCITY

func stop():
	hit = true
	animated_sprite.stop()
