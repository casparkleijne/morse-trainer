extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.letter_selected.connect(_on_letter_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_letter_selected(letter: String):
	print("Checking: ", letter)
	AudioManager.play_character(letter)
