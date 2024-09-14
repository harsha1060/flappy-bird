extends Node2D

class_name Pipes

signal bird_entered
signal point_scored

var speed = 0

func set_speed(new_speed):
	speed = new_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta

func _on_body_entered(_body: Node2D) -> void:
	bird_entered.emit()


func _on_score_gain_body_entered(_body: Node2D) -> void:
	point_scored.emit()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()