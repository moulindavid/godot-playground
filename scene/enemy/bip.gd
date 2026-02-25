extends CharacterBody2D

class_name Bip

var MAX_HP = 3
var hp : int
var speed = 100

func _ready():
	hp = MAX_HP

func take_damage(amount: int):
	hp -= amount
	print("Enemy hit! HP: ", hp, "/", MAX_HP)
	$HPBar.queue_redraw()
	if hp <= 0:
		die()

func die():
	print("Enemy destroyed!")
	queue_free()
