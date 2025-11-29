class_name MainScene
extends Node2D

var progress : int = 0
func _ready() -> void:
	EventBus.paused.emit()
	EventBus.letters_changed.emit("ABCDE")
	EventBus.letter_selected.connect(_on_letter_selected)
	pass

func _on_letter_selected (letter:String):
	
	progress = progress + 1
	EventBus.progress_changed.emit(progress)
