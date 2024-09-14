extends CanvasLayer

class_name UI

@onready var game_over_box: VBoxContainer = $MarginContainer/GameOverBox
@onready var point_label: Label = $MarginContainer/PointLabel

func _ready() -> void:
	point_label.text = str(0)

func update_points(points: int):
	point_label.text = str(points)


func on_game_over():
	game_over_box.visible = true
	set_process_input(true)  # Enable input processing when the game is over

func _on_button_pressed() -> void:
	restart_game()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Jump") and game_over_box.visible:
		restart_game()

func restart_game() -> void:
	get_tree().reload_current_scene()
