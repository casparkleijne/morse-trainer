class_name ScoreScene
extends Control

@onready var level_value: Label = %LevelValue
@onready var level_title: Label = %LevelTitle
@onready var streak_value: Label = %StreakValue
@onready var streak_title: Label = %StreakTitle
@onready var accuracy_value: Label = %AccuracyValue
@onready var accuracy_title: Label = %AccuracyTitle
@onready var attempts_value: Label = %AttemptsValue
@onready var attempts_title: Label = %AttemptsTitle

func _ready():
	EventBus.level_changed.connect(_on_level_changed)
	EventBus.streak_changed.connect(_on_streak_changed)
	EventBus.accuracy_changed.connect(_on_accuracy_changed)
	EventBus.attempts_changed.connect(_on_attempts_changed)
	EventBus.reset.connect(_on_reset)
	
	_set_titles()
	_on_reset()

func _set_titles():
	level_title.text = "Level"
	streak_title.text = "Streak"
	accuracy_title.text = "Accuracy"
	attempts_title.text = "Attempts"

func _on_reset():
	level_value.text = "1"
	streak_value.text = "0"
	accuracy_value.text = "0%"
	attempts_value.text = "0"

func _on_level_changed(level: int):
	level_value.text = str(level)

func _on_streak_changed(streak: int):
	streak_value.text = str(streak)

func _on_accuracy_changed(accuracy: float):
	accuracy_value.text = str(int(accuracy)) + "%"

func _on_attempts_changed(attempts: int):
	attempts_value.text = str(attempts)
