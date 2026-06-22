extends Node

enum Phase { DAWN, DAY, DUSK, NIGHT }

signal phase_changed(new_phase: Phase)
signal hour_changed(hour: int)
signal day_changed(day: int)

# time_of_day: 0.0 = midnight, 0.5 = noon, 1.0 = next midnight
var time_of_day: float = 0.25  # start at 6:00 AM
var day: int = 1
var speed: float = 1.0  # 1.0 = 1 real second per minute; 60 = 1 real second per in-game hour

var _paused: bool = false
var _last_hour: int = -1
var _last_phase: Phase = Phase.DAWN

func _process(delta: float) -> void:
	if _paused:
		return
	time_of_day += delta * speed / 1440.0  # 1440 minutes in a day
	if time_of_day >= 1.0:
		time_of_day -= 1.0
		day += 1
		emit_signal("day_changed", day)
	var h: int = hour()
	if h != _last_hour:
		_last_hour = h
		emit_signal("hour_changed", h)
	var p: Phase = phase()
	if p != _last_phase:
		_last_phase = p
		emit_signal("phase_changed", p)

func hour() -> int:
	return int(time_of_day * 24.0) % 24

func minute() -> int:
	return int(time_of_day * 1440.0) % 60

func phase() -> Phase:
	var h: int = hour()
	if h >= 5 and h < 8:
		return Phase.DAWN
	elif h >= 8 and h < 18:
		return Phase.DAY
	elif h >= 18 and h < 21:
		return Phase.DUSK
	else:
		return Phase.NIGHT

func is_daytime() -> bool:
	var h: int = hour()
	return h >= 8 and h < 18

func set_time(hour_val: int, minute_val: int = 0) -> void:
	time_of_day = (float(hour_val) + float(minute_val) / 60.0) / 24.0

func pause_time() -> void:
	_paused = true

func resume_time() -> void:
	_paused = false

func is_paused() -> bool:
	return _paused

func save_state() -> Dictionary:
	return {"time": time_of_day, "day": day, "speed": speed}

func load_state(data: Dictionary) -> void:
	time_of_day = data.get("time", 0.25)
	day = data.get("day", 1)
	speed = data.get("speed", 1.0)
