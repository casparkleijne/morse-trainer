extends Node
## Tracks per-character mastery for targeted feedback.
##
## Records attempts and correct answers per character to calculate
## individual mastery percentages. Characters with 95%+ accuracy
## are considered mastered.


# ------------------------------------------------------------------------------
# Constants
# ------------------------------------------------------------------------------

## Minimum accuracy percentage to consider a character mastered
const MASTERY_THRESHOLD: float = 95.0

## Minimum attempts before mastery calculation is meaningful
const MIN_ATTEMPTS_FOR_MASTERY: int = 5


# ------------------------------------------------------------------------------
# State
# ------------------------------------------------------------------------------

## Dictionary mapping character -> { "attempts": int, "correct": int }
var _stats: Dictionary = {}


# ------------------------------------------------------------------------------
# Public API
# ------------------------------------------------------------------------------

## Record an attempt for a character
func record_attempt(character: String, is_correct: bool) -> void:
	_ensure_character(character)
	_stats[character]["attempts"] += 1
	if is_correct:
		_stats[character]["correct"] += 1


## Get mastery percentage for a character (0-100)
func get_mastery(character: String) -> float:
	if not _stats.has(character):
		return 0.0
	var stats: Dictionary = _stats[character]
	if stats["attempts"] == 0:
		return 0.0
	return float(stats["correct"]) / float(stats["attempts"]) * 100.0


## Check if character is mastered (95%+ with enough attempts)
func is_mastered(character: String) -> bool:
	if not _stats.has(character):
		return false
	var stats: Dictionary = _stats[character]
	if stats["attempts"] < MIN_ATTEMPTS_FOR_MASTERY:
		return false
	return get_mastery(character) >= MASTERY_THRESHOLD


## Get all mastered characters
func get_mastered_characters() -> Array[String]:
	var mastered: Array[String] = []
	for character: String in _stats.keys():
		if is_mastered(character):
			mastered.append(character)
	return mastered


## Get characters that need work (attempted but not mastered)
func get_struggling_characters() -> Array[String]:
	var struggling: Array[String] = []
	for character: String in _stats.keys():
		var stats: Dictionary = _stats[character]
		if stats["attempts"] >= MIN_ATTEMPTS_FOR_MASTERY and not is_mastered(character):
			struggling.append(character)
	return struggling


## Get stats for a specific character
func get_character_stats(character: String) -> Dictionary:
	if not _stats.has(character):
		return { "attempts": 0, "correct": 0, "mastery": 0.0 }
	var stats: Dictionary = _stats[character]
	return {
		"attempts": stats["attempts"],
		"correct": stats["correct"],
		"mastery": get_mastery(character)
	}


## Get all character stats sorted by mastery (lowest first)
func get_all_stats_sorted() -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	for character: String in _stats.keys():
		var stats: Dictionary = get_character_stats(character)
		stats["character"] = character
		result.append(stats)
	result.sort_custom(_sort_by_mastery)
	return result


## Reset all stats
func reset() -> void:
	_stats.clear()


# ------------------------------------------------------------------------------
# Private Methods
# ------------------------------------------------------------------------------

func _ensure_character(character: String) -> void:
	if not _stats.has(character):
		_stats[character] = { "attempts": 0, "correct": 0 }


func _sort_by_mastery(a: Dictionary, b: Dictionary) -> bool:
	return a["mastery"] < b["mastery"]
