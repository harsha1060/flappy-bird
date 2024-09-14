extends Sprite2D

const BACK_SCROLL : float = 0.5

var back_scroll
var screen_size : Vector2   
var hit =  false

@onready var background: Sprite2D = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set screen_size to the viewport size
	screen_size = get_viewport().size
	back_scroll = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !hit :
		# Increment scroll by the speed
		back_scroll += BACK_SCROLL
		# Wrap scroll when it exceeds the screen width
		if back_scroll >= screen_size.x:
			back_scroll = 0
		# Update the ground and background position
		background.position.x = -back_scroll

func stop():
	hit = true
