extends Control

export var time_in = 0.75
export var time_out = 0.25

signal exited()

var ready = false

func info_show(title, info):
	$Background/Container/Title.text = title
	$Background/Container/Info.text = info
	self.visible = true
	var tween = $Tween
	tween.interpolate_property(self, "rect_position", Vector2(-$Background.rect_size.x, 0.0), Vector2.ZERO, time_in, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func info_hide():
	$Background/Container/Container/Close.mouse_filter = Button.MOUSE_FILTER_IGNORE
	ready = false
	var tween = $Tween
	tween.interpolate_property(self, "rect_position", Vector2.ZERO, Vector2(-$Background.rect_size.x, 0.0), time_out, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_Tween_tween_all_completed():
	if self.rect_position.x > -1.0:
		$Background/Container/Container/Close.mouse_filter = Button.MOUSE_FILTER_STOP
		ready = true
	else:
		self.visible = false

func _on_Close_pressed():
	emit_signal("exited")
