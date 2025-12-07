extends VBoxContainer
## Container for the training UI components.
## Handles visibility based on navigation.


func _ready() -> void:
	EventBus.navigate_training.connect(_on_navigate_training)
	EventBus.navigate_statistics.connect(_on_navigate_statistics)
	EventBus.navigate_settings.connect(_on_navigate_settings)


func _on_navigate_training() -> void:
	visible = true


func _on_navigate_statistics() -> void:
	visible = false


func _on_navigate_settings() -> void:
	visible = false
