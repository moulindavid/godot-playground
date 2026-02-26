extends CharacterBody2D

class_name Ghosty

const SPEED = 300.0
const ATTACK_DAMAGE = 1
const Ball = preload("res://scene/player/attacks/ball.tscn")

const DASH_SPEED = 900.0
const DASH_DURATION = 0.2

# Physics layers: 1 = walls, 4 = enemies (layer 3 in the Inspector)
const MASK_DEFAULT = 1 | 4 
const MASK_DASH    = 1  # only collides with walls during dash

var is_attacking = false
var hit_bodies = []

var is_dashing = false
var dash_timer = 0.0
var dash_direction = Vector2.ZERO


func _physics_process(delta):
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false
			collision_mask = MASK_DEFAULT
		else:
			velocity = dash_direction * DASH_SPEED
			move_and_slide()
			return

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

	if event is InputEventKey and event.keycode == KEY_SPACE and event.pressed and not event.echo and not is_dashing:
		var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		dash_direction = dir if dir != Vector2.ZERO else Vector2.RIGHT
		is_dashing = true
		dash_timer = DASH_DURATION
		collision_mask = MASK_DASH
