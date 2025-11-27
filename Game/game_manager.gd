extends Node

func _ready() -> void:
	EventBus.started.connect(_on_started)
	EventBus.paused.connect(_on_paused)
	EventBus.resetted.connect(_on_resetted)
	EventBus.finished.connect(_on_finished)
	
func _on_started() : 
	pass
	
func _on_paused() : 
	pass
	
func _on_resetted() : 
	pass	
	
func _on_finished() : 
	pass
