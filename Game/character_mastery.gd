extends Node
## Tracks per-character mastery using a sliding window.
##
## Records the last N attempts per character to calculate mastery.
## Uses a sliding window approach for more responsive feedback.


# ------------------------------------------------------------------------------
# Constants
# ------------------------------------------------------------------------------

## Number of attempts to track per character (sliding window size)
const WINDOW_SIZE: int = 20

## Minimum accuracy percentage to consider a character mastered
const MASTERY_THRESHOLD: float = 95.0

## Minimum attempts before mastery calculation is meaningful
const MIN_ATTEMPTS_FOR_MASTERY: int = 5


# ------------------------------------------------------------------------------
# State
# ------------------------------------------------------------------------------

## Dictionary mapping character -> Array of booleans (true = correct, false = incorrect)
var _history: Dictionary = {}


# ------------------------------------------------------------------------------
# Public API
# ------------------------------------------------------------------------------

## Record an attempt for a character
func record_attempt(character: String, is_correct: bool) -> void:
	_ensure_character(character)
	_history[character].append(is_correct)
	# Keep only the last WINDOW_SIZE attempts
	if _history[character].size() > WINDOW_SIZE:
		_history[character].pop_front()


## Get mastery percentage for a character (0-100)
func get_mastery(character: String) -> float:
	if not _history.has(character):
		return 0.0
	var history: Array = _history[character]
	if history.is_empty():
		return 0.0
	var correct_count: int = 0
	for is_correct: bool in history:
		if is_correct:
			correct_count += 1
	return float(correct_count) / float(history.size()) * 100.0


## Check if character is mastered (95%+ with enough attempts)
func is_mastered(character: String) -> bool:
	if not _history.has(character):
		return false
	var history: Array = _history[character]
	if history.size() < MIN_ATTEMPTS_FOR_MASTERY:
		return false
	return get_mastery(character) >= MASTERY_THRESHOLD


## Get all mastered characters
func get_mastered_characters() -> Array[String]:
	var mastered: Array[String] = []
	for character: String in _history.keys():
		if is_mastered(character):
			mastered.append(character)
	return mastered


## Get characters that need work (attempted but not mastered)
func get_struggling_characters() -> Array[String]:
	var struggling: Array[String] = []
	for character: String in _history.keys():
		var history: Array = _history[character]
		if history.size() >= MIN_ATTEMPTS_FOR_MASTERY and not is_mastered(character):
			struggling.append(character)
	return struggling


## Get stats for a specific character
func get_character_stats(character: String) -> Dictionary:
	if not _history.has(character):
		return { "attempts": 0, "correct": 0, "mastery": 0.0 }
	var history: Array = _history[character]
	var correct_count: int = 0
	for is_correct: bool in history:
		if is_correct:
			correct_count += 1
	return {
		"attempts": history.size(),
		"correct": correct_count,
		"mastery": get_mastery(character)
	}


## Get average mastery for characters that have been attempted
func get_average_mastery(characters: String) -> float:
	if characters.is_empty():
		return 0.0
	var total: float = 0.0
	var count: int = 0
	for i: int in range(characters.length()):
		var character: String = characters[i]
		if _history.has(character) and not _history[character].is_empty():
			total += get_mastery(character)
			count += 1
	if count == 0:
		return 0.0
	return total / float(count)


## Get all character stats sorted by mastery (lowest first)
func get_all_stats_sorted() -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	for character: String in _history.keys():
		var stats: Dictionary = get_character_stats(character)
		stats["character"] = character
		result.append(stats)
	result.sort_custom(_sort_by_mastery)
	return result


## Reset stats for specific characters
func reset_characters(characters: String) -> void:
	for i: int in range(characters.length()):
		var character: String = characters[i]
		if _history.has(character):
			_history[character] = []


## Reset all stats
func reset() -> void:
	_history.clear()


# ------------------------------------------------------------------------------
# Private Methods
# ------------------------------------------------------------------------------

func _ensure_character(character: String) -> void:
	if not _history.has(character):
		_history[character] = []


func _sort_by_mastery(a: Dictionary, b: Dictionary) -> bool:
	return a["mastery"] < b["mastery"]
