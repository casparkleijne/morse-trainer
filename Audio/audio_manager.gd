# autoload/audio_manager.gd
extends Node

signal playback_started()
signal playback_finished()

const DIT_DURATION = 0.06  # 60ms = 20 WPM
const DAH_DURATION = DIT_DURATION * 3
const SYMBOL_GAP = DIT_DURATION
const LETTER_GAP = DIT_DURATION * 3
const WORD_GAP = DIT_DURATION * 7
const TONE_FREQUENCY = 700.0  # Hz
const SAMPLE_RATE = 22050

var audio_player: AudioStreamPlayer
var is_playing: bool = false

func _ready():
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.finished.connect(_on_playback_finished)

func play_morse(morse_code: String):
	if is_playing:
		return

	is_playing = true
	playback_started.emit()

	var audio_stream = _generate_morse_audio(morse_code)
	audio_player.stream = audio_stream
	audio_player.play()

func play_character(character: String):
	var morse = MorseData.get_morse(character)
	if morse:
		play_morse(morse)

func stop():
	if audio_player.playing:
		audio_player.stop()
	is_playing = false

func _on_playback_finished():
	is_playing = false
	playback_finished.emit()

func _generate_morse_audio(morse_code: String) -> AudioStreamWAV:
	var samples = PackedFloat32Array()

	for i in range(morse_code.length()):
		var symbol = morse_code[i]

		match symbol:
			".":
				_add_tone(samples, DIT_DURATION)
			"-":
				_add_tone(samples, DAH_DURATION)
			" ":
				_add_silence(samples, LETTER_GAP)
				continue

		# Symbol gap (behalve na laatste symbool)
		if i < morse_code.length() - 1 and morse_code[i + 1] != " ":
			_add_silence(samples, SYMBOL_GAP)

	var stream = AudioStreamWAV.new()
	stream.data = _float_to_bytes(samples)
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = SAMPLE_RATE
	stream.stereo = false

	return stream

func _add_tone(samples: PackedFloat32Array, duration: float):
	var sample_count = int(duration * SAMPLE_RATE)

	for i in range(sample_count):
		var t = float(i) / SAMPLE_RATE
		var sample = sin(2.0 * PI * TONE_FREQUENCY * t)

		# Apply envelope (attack/decay) voor smooth sound
		var envelope = 1.0
		var attack_samples = int(0.005 * SAMPLE_RATE)  # 5ms attack
		var release_samples = int(0.005 * SAMPLE_RATE)  # 5ms release

		if i < attack_samples:
			envelope = float(i) / attack_samples
		elif i > sample_count - release_samples:
			envelope = float(sample_count - i) / release_samples

		samples.append(sample * envelope * 0.3)  # 0.3 = volume

func _add_silence(samples: PackedFloat32Array, duration: float):
	var sample_count = int(duration * SAMPLE_RATE)
	for i in range(sample_count):
		samples.append(0.0)

func _float_to_bytes(samples: PackedFloat32Array) -> PackedByteArray:
	var bytes = PackedByteArray()
	bytes.resize(samples.size() * 2)  # 16-bit = 2 bytes per sample

	for i in range(samples.size()):
		var sample_16bit = int(clamp(samples[i], -1.0, 1.0) * 32767)
		bytes[i * 2] = sample_16bit & 0xFF
		bytes[i * 2 + 1] = (sample_16bit >> 8) & 0xFF

	return bytes

# Settings functies


func set_volume(volume_db: float):
	audio_player.volume_db = volume_db
