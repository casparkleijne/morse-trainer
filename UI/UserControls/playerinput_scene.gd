extends VBoxContainer

## Maximum number of letter cards supported by this UI.
## Change this constant and add corresponding Card nodes to scale up.
const MAX_CARDS := 5

## Cached references to Card container nodes (Control).
## Populated once in _ready() to avoid repeated get_node() calls.
var _cards: Array[Control] = []

## Cached references to the Button inside each Card.
## Index corresponds to _cards array (button 0 is inside card 0).
var _buttons: Array[Button] = []

## Reference to the GridContainer that holds the cards.
## Used to dynamically adjust column count based on active letters.
@onready var _grid: GridContainer = $GridCard/MarginContainer/PanelContainer/MarginContainer/PanelContainer/GridContainer


func _ready() -> void:
	_cache_card_references()
	_connect_signals()
	_set_all_cards_visible(false)


## Finds and caches all Card nodes and their nested Buttons.
## This avoids deep node path lookups on every frame or event.
## Cards are expected to be named Card1, Card2, ... Card{MAX_CARDS} as unique names.
func _cache_card_references() -> void:
	for i in range(1, MAX_CARDS + 1):
		# Cards use unique name syntax (%) so we build the path dynamically
		var card: Control = get_node("%" + "Card" + str(i))
		
		# Navigate the nested container structure to find the actual button
		var button: Button = card.get_node("MarginContainer/PanelContainer/MarginContainer/PanelContainer/Button")
		
		_cards.append(card)
		_buttons.append(button)


## Connects all EventBus signals and button press handlers.
## Centralizes signal wiring for easier debugging and maintenance.
func _connect_signals() -> void:
	# Game state signals - pause/reset disables buttons, start enables them
	EventBus.paused.connect(_set_buttons_disabled.bind(true))
	EventBus.started.connect(_set_buttons_disabled.bind(false))
	EventBus.resetted.connect(_set_buttons_disabled.bind(true))
	
	# Letter pool updates trigger UI refresh
	EventBus.letters_changed.connect(_on_letters_changed)
	
	# Each button emits the same signal with its current text.
	# We pass the button reference (not button.text) so we read the
	# CURRENT text at press time, not the text at connection time.
	for button in _buttons:
		button.pressed.connect(_on_button_pressed.bind(button))


## Shows or hides all card containers at once.
## Used during initialization to hide cards before letters are assigned.
func _set_all_cards_visible(visible: bool) -> void:
	for card in _cards:
		card.visible = visible


## Enables or disables all letter buttons.
## Disabled buttons prevent input during pause or before game starts.
func _set_buttons_disabled(disabled: bool) -> void:
	for button in _buttons:
		button.disabled = disabled


## Called when the available letter pool changes (Koch method progression).
## Updates grid columns, shows/hides cards, and assigns letters to buttons.
func _on_letters_changed(letters: String) -> void:
	var count := letters.length()
	
	# Grid columns match the number of active letters for proper layout
	_grid.columns = count
	
	for i in range(MAX_CARDS):
		var has_letter := i < count
		
		# Only show cards that have a corresponding letter
		_cards[i].visible = has_letter
		
		# Assign the letter, or clear if this card is inactive.
		# Direct index access is safe here because we've checked bounds.
		_buttons[i].text = letters[i] if has_letter else ""


## Handles any letter button press.
## Reads the button's current text and emits it via EventBus.
## This allows the game logic to know which letter the player selected.
func _on_button_pressed(button: Button) -> void:
	EventBus.letter_selected.emit(button.text)
