extends Node2D

const BAR_WIDTH = 44
const BAR_HEIGHT = 6
const BAR_OFFSET = Vector2(-BAR_WIDTH / 2.0, -60)

func _draw():
	var bip = get_parent()
	# background
	draw_rect(Rect2(BAR_OFFSET, Vector2(BAR_WIDTH, BAR_HEIGHT)), Color.BLACK)
	# fill proportional to current hp
	var fill = BAR_WIDTH * (float(bip.hp) / float(bip.MAX_HP))
	draw_rect(Rect2(BAR_OFFSET, Vector2(fill, BAR_HEIGHT)), Color.RED)
