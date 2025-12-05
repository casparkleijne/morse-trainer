extends Node
## Global event bus for decoupled communication between game components.
##
## This autoload singleton enables loose coupling between UI elements and game logic.
## Components emit and listen to signals here without needing direct references to each other.
##
## Usage:
##   Emit:   EventBus.started.emit()
##   Listen: EventBus.started.connect(_on_started)
##
## Note: The @warning_ignore annotations suppress "unused_signal" warnings since
## signals are connected dynamically by other scripts, not within this file.


# ------------------------------------------------------------------------------
# Session State Signals
# ------------------------------------------------------------------------------

## Emitted when the training session begins or resumes from pause.
## Listeners should enable input, start timers, and begin playing morse audio.
@warning_ignore("unused_signal")
signal started()

## Emitted when the training session is temporarily halted.
## Listeners should disable input and pause any ongoing morse playback.
@warning_ignore("unused_signal")
signal paused()

## Emitted when the training session is cleared and returned to initial state.
## Listeners should reset progress, clear UI, and prepare for a fresh session.
@warning_ignore("unused_signal")
signal reset()

## Emitted when all rounds in the training session are completed.
## Listeners should show results, disable input, and enable reset option.
@warning_ignore("unused_signal")
signal finished()


# ------------------------------------------------------------------------------
# Letter Pool Signals
# ------------------------------------------------------------------------------

## Emitted when the available letter pool changes (Koch method progression).
## Listeners should update UI to show the new set of available letters.
## @param letters: String containing all currently active letters (e.g., "KM" or "KMRSU")
@warning_ignore("unused_signal")
signal letters_changed(letters: String)

## Emitted when the player selects a letter as their answer.
## Game logic should compare this against the expected letter and update score/progress.
## @param letter: The single character the player selected
@warning_ignore("unused_signal")
signal letter_selected(letter: String)


# ------------------------------------------------------------------------------
# Progress Signals
# ------------------------------------------------------------------------------

## Emitted when session progress updates (e.g., after each answer).
## Listeners should update progress bars or round counters.
## @param value: Current progress percentage (0.0 to 100.0)
@warning_ignore("unused_signal")
signal progress_changed(value: float)

## Emitted when the player advances to a new level.
## Listeners should update level display and potentially trigger level-up feedback.
## @param level: The new level number (1-indexed)
@warning_ignore("unused_signal")
signal level_changed(level: int)

## Emitted when turn count updates within a level.
## Listeners can use this for detailed progress tracking.
## @param current: Current turn number within the level
## @param total: Total turns required to complete the level
@warning_ignore("unused_signal")
signal turn_changed(current: int, total: int)


# ------------------------------------------------------------------------------
# Score Signals
# ------------------------------------------------------------------------------

## Emitted when the player's streak changes.
## Streak increases on correct answers and resets to zero on incorrect answers.
## @param streak: Current consecutive correct answers
@warning_ignore("unused_signal")
signal streak_changed(streak: int)

## Emitted when the player's accuracy percentage updates.
## Calculated as (correct answers / total attempts) * 100.
## @param accuracy: Current accuracy percentage (0.0 to 100.0)
@warning_ignore("unused_signal")
signal accuracy_changed(accuracy: float)

## Emitted when the total attempt count changes.
## Increments on every answer, regardless of correctness.
## @param attempts: Total number of attempts in current session
@warning_ignore("unused_signal")
signal attempts_changed(attempts: int)


@warning_ignore("unused_signal")
signal input_enabled(enabled: bool)
