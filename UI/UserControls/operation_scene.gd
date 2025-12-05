extends VBoxContainer

## Control panel for managing the morse code training session.
## Provides Start, Pause, and Reset buttons that emit game state signals
## and update their enabled/disabled states based on current session state.

## Button state configurations for each game state.
## Format: { start_disabled, pause_disabled, reset_disabled }
## Using a dictionary makes state transitions explicit and easy to modify.
const BUTTON_STATES := {
	"started":  { "start": true,  "pause": false, "reset": false },
	"paused":   { "start": false, "pause": true,  "reset": false },
	"resetted": { "start": false, "pause": true,  "reset": true  },
	"finished": { "start": true,  "pause": true,  "reset": false },
}

## Reference to the Start button. Begins a new training session.
@onready var _button_start: Button = %ButtonStart

## Reference to the Pause button. Temporarily halts the current session.
@onready var _button_pause: Button = %ButtonPause

## Reference to the Reset button. Stops and clears the current session.
@onready var _button_reset: Button = %ButtonReset


func _ready() -> void:
	_connect_signals()
	_apply_button_state("resetted")


## Connects EventBus game state signals and button press handlers.
func _connect_signals() -> void:
	# Listen for external state changes (e.g., session auto-finish)
	EventBus.started.connect(_on_started)
	EventBus.paused.connect(_on_paused)
	EventBus.reset.connect(_on_resetted)
	EventBus.finished.connect(_on_finished)

	# Button presses emit corresponding EventBus signals
	_button_start.pressed.connect(_on_button_start_pressed)
	_button_pause.pressed.connect(_on_button_pause_pressed)
	_button_reset.pressed.connect(_on_button_reset_pressed)


## Applies a button state configuration from BUTTON_STATES.
## Centralizes all enable/disable logic in one place.
func _apply_button_state(state_name: String) -> void:
	var state: Dictionary = BUTTON_STATES[state_name]
	_button_start.disabled = state["start"]
	_button_pause.disabled = state["pause"]
	_button_reset.disabled = state["reset"]


## Called when the training session starts.
## Disables start (already running), enables pause and reset.
func _on_started() -> void:
	_apply_button_state("started")


## Called when the training session is paused.
## Enables start (to resume), disables pause (already paused), enables reset.
func _on_paused() -> void:
	_apply_button_state("paused")


## Called when the training session is reset to initial state.
## Enables start, disables pause and reset (nothing to pause/reset yet).
func _on_resetted() -> void:
	_apply_button_state("resetted")


## Called when the training session completes (all rounds finished).
## Disables start and pause, enables reset to begin a new session.
func _on_finished() -> void:
	_apply_button_state("finished")


## Emits the started signal to begin or resume the training session.
func _on_button_start_pressed() -> void:
	EventBus.started.emit()


## Emits the paused signal to halt the current session.
func _on_button_pause_pressed() -> void:
	EventBus.paused.emit()


## Emits the resetted signal to clear and restart the session.
func _on_button_reset_pressed() -> void:
	EventBus.reset.emit()
