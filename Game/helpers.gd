extends Node

func get_turns_for_level(level: int) -> int:
	var letter_count: int
	
	if level <= 0:
		letter_count = 2
	elif level <= 3:
		letter_count = level + 1
	else:
		letter_count = 5
	
	return letter_count * 10

func get_letters_for_level(level: int) -> String:
	var letters: String
	
	if level <= 0:
		letters = MorseData.KOCH_ORDER.substr(0, 2)
	elif level <= 3:
		letters = MorseData.KOCH_ORDER.substr(0, level + 1)
	else:
		var start_index = level - 3
		var max_start = MorseData.KOCH_ORDER.length() - 5
		start_index = min(start_index, max_start)
		letters = MorseData.KOCH_ORDER.substr(start_index, 5)
	
	var arr: Array[String] = []
	for c in letters:
		arr.append(c)
	arr.shuffle()
	return "".join(PackedStringArray(arr))
