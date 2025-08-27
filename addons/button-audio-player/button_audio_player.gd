# Copyright (c) 2025 xiSage
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

@icon("res://addons/button-audio-player/icon.svg")
class_name ButtonAudioPlayer extends AudioStreamPlayer


@export var audio_down: AudioStream
@export var audio_up: AudioStream
@export var audio_pressed: AudioStream
@export var audio_toggled_on_pressed: AudioStream
@export var audio_toggled_on_released: AudioStream
@export var audio_mouse_entered: AudioStream
@export var audio_mouse_exited: AudioStream
@export var audio_focus_entered: AudioStream
@export var audio_focus_exited: AudioStream
@export var stop_on_exited: bool = false

var button: BaseButton = null:
	get:
		return button
	set(value):
		unregister_signals(button)
		button = value
		register_signals()


func _ready() -> void:
	call_deferred("update_button")


func update_button() -> void:
	if button == null:
		button = get_parent() as BaseButton


func register_signals() -> void:
	if button != null:
		button.button_down.connect(on_button_down)
		button.button_up.connect(on_button_up)
		button.pressed.connect(on_button_pressed)
		button.toggled.connect(on_button_toggled)
		button.mouse_entered.connect(on_mouse_entered)
		button.mouse_exited.connect(on_mouse_exited)
		button.focus_entered.connect(on_focus_entered)
		button.focus_exited.connect(on_focus_exited)


func unregister_signals(what: BaseButton) -> void:
	if what != null:
		what.button_down.disconnect(on_button_down)
		what.button_up.disconnect(on_button_up)
		what.pressed.disconnect(on_button_pressed)
		what.toggled.disconnect(on_button_toggled)
		what.mouse_entered.disconnect(on_mouse_entered)
		what.mouse_exited.disconnect(on_mouse_exited)
		what.focus_entered.disconnect(on_focus_entered)
		what.focus_exited.disconnect(on_focus_exited)


func on_button_down() -> void:
	if audio_down != null:
		self.stream = audio_down
		play()


func on_button_up() -> void:
	if audio_up != null:
		self.stream = audio_up
		play()


func on_button_pressed() -> void:
	if audio_pressed != null:
		self.stream = audio_pressed
		play()


func on_button_toggled(toggled_on: bool) -> void:
	if toggled_on and audio_toggled_on_pressed:
		self.stream = audio_toggled_on_pressed
		play()
	elif !toggled_on and audio_toggled_on_released:
		self.stream = audio_toggled_on_released
		play()


func on_mouse_entered() -> void:
	if audio_mouse_entered != null:
		self.stream = audio_mouse_entered
		play()


func on_mouse_exited() -> void:
	if stop_on_exited:
		stop()
	if audio_mouse_exited != null:
		self.stream = audio_mouse_exited
		play()


func on_focus_entered() -> void:
	if audio_focus_entered != null:
		self.stream = audio_focus_entered
		play()


func on_focus_exited() -> void:
	if stop_on_exited:
		stop()
	if audio_focus_exited != null:
		self.stream = audio_focus_exited
