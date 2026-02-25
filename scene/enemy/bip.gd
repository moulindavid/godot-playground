extends CharacterBody2D

class_name Bip

const HitEffect = preload("res://scene/player/attacks/hit_effect.tscn")

var MAX_HP = 20
var hp : int
var speed = 100

var knockback_velocity := Vector2.ZERO

func _ready():
	hp = MAX_HP

func _physics_process(delta: float) -> void:
	velocity = knockback_velocity
	move_and_slide()
	knockback_velocity = knockback_velocity.lerp(Vector2.ZERO, 1.0 - exp(-10.0 * delta))

func take_damage(amount: int):
	hp -= amount
	print("Enemy hit! HP: ", hp, "/", MAX_HP)
	$HPBar.queue_redraw()
	var fx = HitEffect.instantiate()
	fx.position = position
	get_parent().add_child(fx)
	if hp <= 0:
		die()

func knockback(direction: Vector2, force: float) -> void:
	knockback_velocity += direction * force

func die():
	print("Enemy destroyed!")
	queue_free()
