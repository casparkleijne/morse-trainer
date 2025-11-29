# autoload/morse_data.gd
extends Node

const KOCH_ORDER = "KMRSUAPTLOWI.NJEF0YVG5/Q9ZH38B?427C1D6X"

const MORSE_CODE = {
	"A": ".-",     "B": "-...",   "C": "-.-.",
	"D": "-..",    "E": ".",      "F": "..-.",
	"G": "--.",    "H": "....",   "I": "..",
	"J": ".---",   "K": "-.-",    "L": ".-..",
	"M": "--",     "N": "-.",     "O": "---",
	"P": ".--.",   "Q": "--.-",   "R": ".-.",
	"S": "...",    "T": "-",      "U": "..-",
	"V": "...-",   "W": ".--",    "X": "-..-",
	"Y": "-.--",   "Z": "--..",
	"0": "-----",  "1": ".----",  "2": "..---",
	"3": "...--",  "4": "....-",  "5": ".....",
	"6": "-....",  "7": "--...",  "8": "---..",
	"9": "----.",
	".": ".-.-.-", "/": "-..-.",  "?": "..--.."
}

func get_characters(lesson_number: int) -> String:
	var char_count = mini(lesson_number * 2, KOCH_ORDER.length())
	return KOCH_ORDER.substr(0, char_count)

func get_morse(character: String) -> String:
	return MORSE_CODE.get(character.to_upper(), "")

func is_valid_character(character: String) -> bool:
	return MORSE_CODE.has(character.to_upper())
