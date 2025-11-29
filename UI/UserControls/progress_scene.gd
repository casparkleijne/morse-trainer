extends VBoxContainer

## Displays the player's current progress through a morse code training session.
## Listens for progress updates via EventBus and updates the visual progress bar.

## Reference to the ProgressBar UI element.
## Expected to be a unique name (%) child of this container.
@onready var _progress_bar: ProgressBar = %ProgressBar


func _ready() -> void:
	_connect_signals()


## Connects to EventBus signals for progress tracking.
func _connect_signals() -> void:
	EventBus.progress_changed.connect(_on_progress_changed)


## Called when the session progress changes (e.g., after each correct/incorrect answer).
## Updates the progress bar to reflect how far the player is through the current round.
func _on_progress_changed(value: int) -> void:
	_progress_bar.value = value
