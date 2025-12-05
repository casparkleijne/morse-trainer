extends VBoxContainer
## Player input UI for letter selection.
##
## Manages a grid of letter buttons that the player uses to answer morse code
## challenges. Responds to game state changes and letter pool updates.


# ------------------------------------------------------------------------------
# Constants
# ------------------------------------------------------------------------------

## Maximum number of letter cards supported by this UI.
## Change this constant and add corresponding Card nodes to scale up.
const MAX_CARDS := 5


# ------------------------------------------------------------------------------
# State Variables
# ------------------------------------------------------------------------------

## Cached references to Card container nodes (Control).
## Populated once in _ready() to avoid repeated get_node() calls.
var _cards: Array[Control] = []

## Cached references to the Button inside each Card.
## Index corresponds to _cards array (button 0 is inside card 0).
var _buttons: Array[Button] = []


# ------------------------------------------------------------------------------
# Nodes
# ------------------------------------------------------------------------------

## Reference to the GridContainer that holds the cards.
## Used to dynamically adjust column count based on active letters.
@onready var _grid: GridContainer = $GridCard/MarginContainer/PanelContainer/MarginContainer/PanelContainer/GridContainer


# ------------------------------------------------------------------------------
# Lifecycle
# ------------------------------------------------------------------------------

func _ready() -> void:
	_cache_card_references()
	_connect_signals()
	_set_all_cards_visible(false)


# ------------------------------------------------------------------------------
# Setup Methods
# ------------------------------------------------------------------------------

## Finds and caches all Card nodes and their nested Buttons.
## This avoids deep node path lookups on every frame or event.
## Cards are expected to be named Card1, Card2, ... Card{MAX_CARDS} as unique names.
func _cache_card_references() -> void:
	for i in range(1, MAX_CARDS + 1):
		var card: Control = get_node("%" + "Card" + str(i))
		var button: Button = card.get_node("MarginContainer/PanelContainer/MarginContainer/PanelContainer/Button")
		
		_cards.append(card)
		_buttons.append(button)


## Connects all EventBus signals and button press handlers.
## Centralizes signal wiring for easier debugging and maintenance.
func _connect_signals() -> void:
	EventBus.input_enabled.connect(_on_input_enabled)
	EventBus.letters_changed.connect(_on_letters_changed)

	for button in _buttons:
		button.pressed.connect(_on_button_pressed.bind(button))


# ------------------------------------------------------------------------------
# Event Handlers
# ------------------------------------------------------------------------------

## Enables or disables all letter buttons based on input_enabled signal.
func _on_input_enabled(enabled: bool) -> void:
	for button in _buttons:
		button.disabled = not enabled


## Called when the available letter pool changes (Koch method progression).
## Updates grid columns, shows/hides cards, and assigns letters to buttons.
func _on_letters_changed(letters: String) -> void:
	var count := letters.length()

	_grid.columns = count

	for i in range(MAX_CARDS):
		var has_letter := i < count
		_cards[i].visible = has_letter
		_buttons[i].text = letters[i] if has_letter else ""


## Handles any letter button press.
## Reads the button's current text and emits it via EventBus.
func _on_button_pressed(button: Button) -> void:
	EventBus.letter_selected.emit(button.text)


# ------------------------------------------------------------------------------
# Helper Methods
# ------------------------------------------------------------------------------

## Shows or hides all card containers at once.
## Used during initialization to hide cards before letters are assigned.
func _set_all_cards_visible(visibility: bool) -> void:
	for card in _cards:
		card.visible = visibility
