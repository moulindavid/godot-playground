extends Area2D

const SPEED = 400.0
const RADIUS = 5.0

var direction = Vector2.RIGHT
var shooter: Node = null

func _ready():
	body_entered.connect(_on_body_entered)

func _process(delta):
	position += direction * SPEED * delta

func _draw():
	draw_circle(Vector2.ZERO, RADIUS, Color.YELLOW)

func _on_body_entered(body):
	if body == shooter:
		return
	if body.has_method("take_damage"):
		body.take_damage(1)
	queue_free()
