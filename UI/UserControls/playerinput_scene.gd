extends VBoxContainer

@onready var button1 = %Card1/MarginContainer/PanelContainer/MarginContainer/PanelContainer/Button
@onready var button2 = %Card2/MarginContainer/PanelContainer/MarginContainer/PanelContainer/Button
@onready var button3 = %Card3/MarginContainer/PanelContainer/MarginContainer/PanelContainer/Button
@onready var button4 = %Card4/MarginContainer/PanelContainer/MarginContainer/PanelContainer/Button
@onready var button5 = %Card5/MarginContainer/PanelContainer/MarginContainer/PanelContainer/Button
@onready var grid : GridContainer =  $GridCard/MarginContainer/PanelContainer/MarginContainer/PanelContainer/GridContainer	
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	button1.pressed.connect(_on_button_pressed.bind(button1.text))
	button2.pressed.connect(_on_button_pressed.bind(button2.text))
	button3.pressed.connect(_on_button_pressed.bind(button3.text))
	button4.pressed.connect(_on_button_pressed.bind(button4.text))
	button5.pressed.connect(_on_button_pressed.bind(button5.text))	
	
	var columns : int = 3;
	grid.columns = columns

	%Card1.visible = columns > 0 
	%Card2.visible = columns > 1
	%Card3.visible = columns > 2
	%Card4.visible = columns > 3
	%Card5.visible = columns > 4	


func _on_button_pressed(letter: String):
	AudioManager.play_character(letter)
	
	
func _on_morse_finished():
	# Wat moet er gebeuren als de morse klaar is?
	print("Morse afgespeeld")
	# Bijvoorbeeld: enable input, volgende karakter, etc

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
