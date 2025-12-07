extends VBoxContainer
## Navigation bar for switching between training, statistics, and settings views.


# ------------------------------------------------------------------------------
# Nodes
# ------------------------------------------------------------------------------

@onready var _button_training: Button = %ButtonTraining
@onready var _button_statistics: Button = %ButtonStatistics
@onready var _button_settings: Button = %ButtonSettings


# ------------------------------------------------------------------------------
# Lifecycle
# ------------------------------------------------------------------------------

func _ready() -> void:
	_button_training.pressed.connect(_on_training_pressed)
	_button_statistics.pressed.connect(_on_statistics_pressed)
	_button_settings.pressed.connect(_on_settings_pressed)

	EventBus.navigate_training.connect(_on_navigate_training)
	EventBus.navigate_statistics.connect(_on_navigate_statistics)
	EventBus.navigate_settings.connect(_on_navigate_settings)

	_on_navigate_training()


# ------------------------------------------------------------------------------
# Event Handlers
# ------------------------------------------------------------------------------

func _on_training_pressed() -> void:
	EventBus.navigate_training.emit()


func _on_statistics_pressed() -> void:
	EventBus.paused.emit()
	EventBus.navigate_statistics.emit()


func _on_settings_pressed() -> void:
	EventBus.paused.emit()
	EventBus.navigate_settings.emit()


func _on_navigate_training() -> void:
	_button_training.disabled = true
	_button_statistics.disabled = false
	_button_settings.disabled = false


func _on_navigate_statistics() -> void:
	_button_training.disabled = false
	_button_statistics.disabled = true
	_button_settings.disabled = false


func _on_navigate_settings() -> void:
	_button_training.disabled = false
	_button_statistics.disabled = false
	_button_settings.disabled = true
