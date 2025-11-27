extends Node

var round_timer = Timer.new()
	
func _ready() -> void:
	EventBus.started.connect(_on_started)
	EventBus.paused.connect(_on_paused)
	EventBus.resetted.connect(_on_resetted)
	EventBus.finished.connect(_on_finished)
	
	round_timer.autostart = false
	round_timer.one_shot = true
	round_timer.ignore_time_scale = true
	round_timer.timeout.connect(_on_finished)
	
	add_child(round_timer) 

func _on_started() : 
	round_timer.start(5)
	
func _on_paused() : 
	round_timer.stop()
	
func _on_resetted() : 
	round_timer.start(5)
	
func _on_finished() : 
	AudioManager.play_character("W")
	round_timer.stop()
