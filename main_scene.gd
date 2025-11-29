class_name MainScene
extends Node2D
## Main game controller that manages level progression and turn tracking.
##
## Implements the Koch method for learning morse code:
## - Start with 2 characters at full speed
## - Add one character when 90% accuracy is achieved
## - Minimum number of attempts required before level up


# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

## Time in seconds before automatically advancing to next turn
@export var turn_timeout: float = 3.0

## Time in seconds to wait after answer
@export var answer_delay: float = 1.0

## Minimum accuracy percentage required to advance to next level (Koch: 90%)
@export var required_accuracy: float = 90.0

## Minimum attempts required before level up is possible
@export var min_attempts_for_level: int = 20


# ------------------------------------------------------------------------------
# State Variables
# ------------------------------------------------------------------------------

## Current level in Koch method progression (1-indexed)
## Level 1 = 2 characters, Level 2 = 3 characters, etc.
var level: int = 1

## Total attempts in current level
var attempts: int = 0

## Total correct answers in current level
var correct: int = 0

## Current streak of correct answers
var streak: int = 0

## Current letter the player needs to guess
var current_letter: String = ""

## Available letters for current level
var current_letters: String = ""


# ------------------------------------------------------------------------------
# Nodes
# ------------------------------------------------------------------------------

@onready var turn_timer: Timer = $TurnTimer


# ------------------------------------------------------------------------------
# Lifecycle
# ------------------------------------------------------------------------------

func _ready() -> void:
	_setup_timer()
	EventBus.paused.emit()
	EventBus.reset.connect(_on_reset)
	EventBus.started.connect(_on_started)
	EventBus.paused.connect(_on_paused)
	EventBus.letter_selected.connect(_on_letter_selected)
	_emit_all()


func _setup_timer() -> void:
	turn_timer.wait_time = turn_timeout
	turn_timer.one_shot = true
	turn_timer.timeout.connect(_on_turn_timeout)


# ------------------------------------------------------------------------------
# Event Handlers
# ------------------------------------------------------------------------------

func _on_reset() -> void:
	level = 1
	attempts = 0
	correct = 0
	streak = 0
	turn_timer.stop()
	EventBus.input_enabled.emit(false)
	_emit_all()


func _on_started() -> void:
	_start_new_round()


func _on_paused() -> void:
	turn_timer.stop()
	EventBus.input_enabled.emit(false)


func _on_turn_timeout() -> void:
	attempts += 1
	streak = 0
	_emit_stats()
	_emit_progress()
	_repeat_round()


func _on_letter_selected(letter: String) -> void:
	turn_timer.stop()
	EventBus.input_enabled.emit(false)
	
	if letter == current_letter:
		_complete_turn()
	else:
		attempts += 1
		streak = 0
		_emit_stats()
		_emit_progress()
		await get_tree().create_timer(answer_delay).timeout
		_repeat_round()


# ------------------------------------------------------------------------------
# Round Methods
# ------------------------------------------------------------------------------

func _start_new_round() -> void:
	EventBus.input_enabled.emit(false)
	current_letter = _pick_random_letter()
	_play_letter(current_letter)
	turn_timer.start()
	EventBus.input_enabled.emit(true)


func _repeat_round() -> void:
	EventBus.input_enabled.emit(false)
	_play_letter(current_letter)
	turn_timer.start()
	EventBus.input_enabled.emit(true)


func _complete_turn() -> void:
	attempts += 1
	correct += 1
	streak += 1
	_emit_stats()
	
	if _can_level_up():
		_level_up()
	
	_emit_progress()
	
	await get_tree().create_timer(answer_delay).timeout
	_start_new_round()


func _can_level_up() -> bool:
	if attempts < min_attempts_for_level:
		return false
	
	var accuracy: float = float(correct) / float(attempts) * 100.0
	return accuracy >= required_accuracy


func _level_up() -> void:
	level += 1
	attempts = 0
	correct = 0
	current_letters = Helpers.get_letters_for_level(level)
	EventBus.letters_changed.emit(current_letters)
	EventBus.level_changed.emit(level)
	_emit_stats()


# ------------------------------------------------------------------------------
# Helper Methods
# ------------------------------------------------------------------------------

func _pick_random_letter() -> String:
	return current_letters[randi() % current_letters.length()]


func _play_letter(letter: String) -> void:
	AudioManager.play_character(letter)


func _emit_stats() -> void:
	var accuracy: float = 0.0
	if attempts > 0:
		accuracy = float(correct) / float(attempts) * 100.0
	EventBus.attempts_changed.emit(attempts)
	EventBus.streak_changed.emit(streak)
	EventBus.accuracy_changed.emit(accuracy)


func _emit_progress() -> void:
	if attempts < min_attempts_for_level:
		# Progress naar minimum attempts
		var progress: float = float(attempts) / float(min_attempts_for_level) * 100.0
		EventBus.progress_changed.emit(progress)
	else:
		# Genoeg attempts: progress is gebaseerd op accuracy richting target
		var accuracy: float = float(correct) / float(attempts) * 100.0
		var progress: float = accuracy / required_accuracy * 100.0
		progress = min(progress, 100.0)
		EventBus.progress_changed.emit(progress)


func _emit_all() -> void:
	current_letters = Helpers.get_letters_for_level(level)
	EventBus.letters_changed.emit(current_letters)
	EventBus.level_changed.emit(level)
	_emit_stats()
	_emit_progress()
