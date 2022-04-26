extends Spatial

signal _spectated(spectator)

export var wave_speed = 0.25
export var wave_distance = 0.25
export var wave_offset = 1.75
export var wave_angle = 0.0

func _process(delta):
	wave_angle = fmod(wave_angle + PI * wave_speed * delta, PI * 2.0)
	var wave = sin(wave_angle)
	wave = wave * wave
	$ExibitBody.translation.y = wave_offset + wave * wave_distance


func _on_Spectator_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("_spectated", $Spectator)
