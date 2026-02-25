extends CharacterBody2D

class_name Ghosty

const SPEED = 300.0
const ATTACK_DAMAGE = 1
const Ball = preload("res://scene/player/attacks/ball.tscn")

var is_attacking = false
var hit_bodies = []


func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var target_velocity = direction * SPEED
	velocity = velocity.lerp(target_velocity, 1.0 - exp(-50 * get_physics_process_delta_time()))

	move_and_slide()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var ball = Ball.instantiate()
		ball.position = global_position
		ball.direction = (get_global_mouse_position() - global_position).normalized()
		ball.shooter = self
		get_parent().add_child(ball)
