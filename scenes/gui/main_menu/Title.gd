extends Node

export var time_fade = 1.0

func _ready():
	$Tween.interpolate_property($Title, "percent_visible", 0.0, 1.0, time_fade, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
