# autoload/morse_data.gd
extends Node


const KOCH_ORDER = [
	"K", "M",           # Les 1-2
	"R", "S", "U",      # Les 3-5
	"A", "P", "T",      # Les 6-8
	"L", "O", "W",      # Les 9-11
	"I", ".", "N",      # Les 12-14
	"J", "E", "F",      # Les 15-17
	"0", "Y", "V",      # Les 18-20
	"G", "5", "/",      # Les 21-23
	"Q", "9", "Z",      # Les 24-26s
	"H", "3", "8",      # Les 27-29
	"B", "?", "4",      # Les 30-32
	"2", "7", "C",      # Les 33-35
	"1", "D", "6",      # Les 36-38
	"X"                 # Les 39-40
]

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

func get_characters(lesson_number: int) -> Array:
	var char_count = min(lesson_number * 2, KOCH_ORDER.size())
	return KOCH_ORDER.slice(0, char_count)

func get_morse(character: String) -> String:
	return MORSE_CODE.get(character.to_upper(), "")

func is_valid_character(character: String) -> bool:
	return MORSE_CODE.has(character.to_upper())
