class_name MusicManager
extends Manager

enum musicTheme {
	BACKGROUND,
	BATTLE
}

var music: Array[AudioStreamMP3] = []

@export var backgroundMusic: AudioStreamMP3 = preload("res://Music/raw/seaark.mp3")
@export var battleMusic: AudioStreamMP3 = preload("res://Music/raw/normalbattle.mp3")

@onready var musicPlayer: AudioStreamPlayer = $BGM

@export var musicEnabled: bool = false

func _ready():
	music.append(backgroundMusic)
	music.append(battleMusic)
	
	if musicEnabled:
		musicPlayer.autoplay = true
	
	changeMusic(musicTheme.BACKGROUND)

func changeMusic(theme: musicTheme):
	musicPlayer.stream = music[theme]
	
	if musicEnabled:
		musicPlayer.play()
