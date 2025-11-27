extends VBoxContainer

@onready var button_start : Button = $GridCard/MarginContainer/PanelContainer/MarginContainer/PanelContainer/GridContainer/Card/MarginContainer/PanelContainer/MarginContainer/PanelContainer/Button
@onready var button_pause : Button = $GridCard/MarginContainer/PanelContainer/MarginContainer/PanelContainer/GridContainer/Card2/MarginContainer/PanelContainer/MarginContainer/PanelContainer/Button
@onready var button_reset : Button = $GridCard/MarginContainer/PanelContainer/MarginContainer/PanelContainer/GridContainer/Card3/MarginContainer/PanelContainer/MarginContainer/PanelContainer/Button

func _ready() -> void:
	EventBus.started.connect(_on_started)
	EventBus.paused.connect(_on_paused)
	EventBus.resetted.connect(_on_resetted)
	EventBus.finished.connect(_on_finished)

	
func _on_started() : 
	button_start.disabled = true;
	button_pause.disabled = false;
	button_reset.disabled = false;
	pass
	
func _on_paused() : 
	button_start.disabled = false;
	button_pause.disabled = true;
	button_reset.disabled = false;
	pass
	
func _on_resetted() : 
	button_start.disabled = false;
	button_pause.disabled = true;
	button_reset.disabled = true;
	pass	
	
func _on_finished() : 
	button_start.disabled = true;
	button_pause.disabled = true;
	button_reset.disabled = false;
	pass
	
func _on_button_start_pressed() -> void:
	EventBus.started.emit();

func _on_button_pause_pressed() -> void:
	EventBus.paused.emit();

func _on_button_reset_pressed() -> void:
	EventBus.resetted.emit();
