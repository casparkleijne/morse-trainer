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
signal resetted()

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
## @param value: Current progress value (interpretation depends on UI, e.g., percentage or round number)
@warning_ignore("unused_signal")
signal progress_changed(value: int)
