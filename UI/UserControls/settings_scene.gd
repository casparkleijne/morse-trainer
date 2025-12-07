class_name SettingsScene
extends VBoxContainer
## Settings panel for audio configuration.


# ------------------------------------------------------------------------------
# Constants
# ------------------------------------------------------------------------------

const CoreCardScene = preload("res://UI/CustomControls/core_card.tscn")


# ------------------------------------------------------------------------------
# Nodes
# ------------------------------------------------------------------------------

@onready var _grid: GridContainer = \
	$GridCard/MarginContainer/PanelContainer/MarginContainer/PanelContainer/GridContainer

var _wpm_slider: HSlider
var _wpm_label: Label
var _freq_slider: HSlider
var _freq_label: Label


# ------------------------------------------------------------------------------
# Lifecycle
# ------------------------------------------------------------------------------

func _ready() -> void:
	_create_settings_ui()
	_connect_signals()
	_update_labels()
	visible = false


# ------------------------------------------------------------------------------
# Setup Methods
# ------------------------------------------------------------------------------

func _create_settings_ui() -> void:
	# Speed setting
	var speed_card: CoreCard = CoreCardScene.instantiate()
	speed_card.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_grid.add_child(speed_card)

	var speed_vbox := VBoxContainer.new()
	speed_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL

	var speed_header := HBoxContainer.new()
	var speed_title := Label.new()
	speed_title.text = "Speed (WPM)"
	speed_title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_wpm_label = Label.new()
	_wpm_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	speed_header.add_child(speed_title)
	speed_header.add_child(_wpm_label)

	_wpm_slider = HSlider.new()
	_wpm_slider.min_value = 15
	_wpm_slider.max_value = 60
	_wpm_slider.step = 1
	_wpm_slider.value = AudioManager.wpm
	_wpm_slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL

	speed_vbox.add_child(speed_header)
	speed_vbox.add_child(_wpm_slider)
	speed_card.content.add_child(speed_vbox)

	# Frequency setting
	var freq_card: CoreCard = CoreCardScene.instantiate()
	freq_card.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_grid.add_child(freq_card)

	var freq_vbox := VBoxContainer.new()
	freq_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL

	var freq_header := HBoxContainer.new()
	var freq_title := Label.new()
	freq_title.text = "Frequency (Hz)"
	freq_title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_freq_label = Label.new()
	_freq_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	freq_header.add_child(freq_title)
	freq_header.add_child(_freq_label)

	_freq_slider = HSlider.new()
	_freq_slider.min_value = 440
	_freq_slider.max_value = 1320
	_freq_slider.step = 10
	_freq_slider.value = AudioManager.frequency
	_freq_slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL

	freq_vbox.add_child(freq_header)
	freq_vbox.add_child(_freq_slider)
	freq_card.content.add_child(freq_vbox)

	# Test button
	var test_card: CoreCard = CoreCardScene.instantiate()
	test_card.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_grid.add_child(test_card)

	var test_button := Button.new()
	test_button.text = "test sound"
	test_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	test_button.pressed.connect(_on_test_pressed)
	test_card.content.add_child(test_button)


func _connect_signals() -> void:
	EventBus.navigate_training.connect(_on_navigate_training)
	EventBus.navigate_statistics.connect(_on_navigate_statistics)
	EventBus.navigate_settings.connect(_on_navigate_settings)

	_wpm_slider.value_changed.connect(_on_wpm_changed)
	_freq_slider.value_changed.connect(_on_freq_changed)


# ------------------------------------------------------------------------------
# Event Handlers
# ------------------------------------------------------------------------------

func _on_navigate_training() -> void:
	visible = false


func _on_navigate_statistics() -> void:
	visible = false


func _on_navigate_settings() -> void:
	visible = true
	_wpm_slider.value = AudioManager.wpm
	_freq_slider.value = AudioManager.frequency
	_update_labels()


func _on_wpm_changed(value: float) -> void:
	AudioManager.wpm = value
	_update_labels()


func _on_freq_changed(value: float) -> void:
	AudioManager.frequency = value
	_update_labels()


func _on_test_pressed() -> void:
	AudioManager.play_morse("- . ... -")  # Play 'TEST'


# ------------------------------------------------------------------------------
# Helper Methods
# ------------------------------------------------------------------------------

func _update_labels() -> void:
	_wpm_label.text = str(int(AudioManager.wpm))
	_freq_label.text = str(int(AudioManager.frequency))
