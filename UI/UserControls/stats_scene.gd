class_name StatsScene
extends VBoxContainer
## Displays per-letter mastery statistics for all Koch letters.
##
## Shows all letters with visual distinction between practiced and not practiced.


# ------------------------------------------------------------------------------
# Constants
# ------------------------------------------------------------------------------

const CoreCardScene = preload("res://UI/CustomControls/core_card.tscn")


# ------------------------------------------------------------------------------
# Nodes
# ------------------------------------------------------------------------------

@onready var _grid: GridContainer = \
	$GridCard/MarginContainer/PanelContainer/MarginContainer/PanelContainer/GridContainer


# ------------------------------------------------------------------------------
# State
# ------------------------------------------------------------------------------

var _letter_labels: Array[Label] = []
var _mastery_labels: Array[Label] = []
var _cards: Array[Control] = []


# ------------------------------------------------------------------------------
# Lifecycle
# ------------------------------------------------------------------------------

func _ready() -> void:
	_create_letter_cards()
	_connect_signals()
	visible = false


# ------------------------------------------------------------------------------
# Setup Methods
# ------------------------------------------------------------------------------

func _create_letter_cards() -> void:
	for character in MorseData.KOCH_ORDER:
		var card: CoreCard = CoreCardScene.instantiate()
		card.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		var hbox := HBoxContainer.new()
		hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		var letter_label := Label.new()
		letter_label.text = character
		letter_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		letter_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT

		var mastery_label := Label.new()
		mastery_label.text = "-"
		mastery_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT

		hbox.add_child(letter_label)
		hbox.add_child(mastery_label)

		_grid.add_child(card)
		card.content.add_child(hbox)

		_cards.append(card)
		_letter_labels.append(letter_label)
		_mastery_labels.append(mastery_label)


func _connect_signals() -> void:
	EventBus.accuracy_changed.connect(_on_accuracy_changed)
	EventBus.reset.connect(_on_reset)
	EventBus.navigate_training.connect(_on_navigate_training)
	EventBus.navigate_statistics.connect(_on_navigate_statistics)
	EventBus.navigate_settings.connect(_on_navigate_settings)


# ------------------------------------------------------------------------------
# Event Handlers
# ------------------------------------------------------------------------------

func _on_accuracy_changed(_accuracy: float) -> void:
	if visible:
		_update_display()


func _on_reset() -> void:
	_update_display()


func _on_navigate_training() -> void:
	visible = false


func _on_navigate_statistics() -> void:
	visible = true
	_update_display()


func _on_navigate_settings() -> void:
	visible = false


# ------------------------------------------------------------------------------
# Helper Methods
# ------------------------------------------------------------------------------

func _update_display() -> void:
	for i in range(MorseData.KOCH_ORDER.length()):
		var character: String = MorseData.KOCH_ORDER[i]
		var stats: Dictionary = CharacterMastery.get_character_stats(character)
		var attempts: int = stats["attempts"]
		var mastery: float = stats["mastery"]

		if attempts > 0:
			_mastery_labels[i].text = str(int(mastery)) + "%"
			_cards[i].modulate = Color.WHITE
			_letter_labels[i].modulate = Color.WHITE
			_mastery_labels[i].modulate = Color.WHITE
		else:
			_mastery_labels[i].text = "-"
			_cards[i].modulate = Color(1, 1, 1, 0.3)
			_letter_labels[i].modulate = Color(1, 1, 1, 0.3)
			_mastery_labels[i].modulate = Color(1, 1, 1, 0.3)
