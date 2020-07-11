extends Control

signal enterSelectMode;

onready var camera :Camera2D = get_node("Camera2D");
onready var mapController := get_node("MainMap");
onready var ghost := get_node("MainPlayer");

#UI
onready var UI := get_node("UI");


var currentLevel = 1;

#for character selection
var currentPlayableCharacter = null;
var currentIndexToSelectCharacter = 0;

#Win variables
var amountOfCharactersInMap;
var amountCharacterTaken;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	yield(get_tree().create_timer(2), "timeout");
#	connect()
	StartGame();


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func StartGame():
	currentPlayableCharacter = null;
	amountCharacterTaken = 0;
	amountOfCharactersInMap = mapController.GetAmountOfCharactersInMap();
	mapController.ReadyUpMap();
	yield(get_tree().create_timer(2), "timeout");
	ghost.EnterGhostToMap();
	SelectCharacter(currentIndexToSelectCharacter);
	pass

func WinGame():
	currentLevel += 1;
	StartGame();

func LostGame():
	RestartGame();

func RestartGame():
	mapController.RestartMapEntities();

func _input(event: InputEvent) -> void:
	HandleMovingPlayableCharacter();


func HandleMovingPlayableCharacter():
	pass


func GhostTookCharacter():
	amountCharacterTaken += 1;
	_checkIfWonGame();

func _checkIfWonGame():
	if(amountCharacterTaken >= amountOfCharactersInMap):
		WinGame();

func SelectCharacterFirstTime():
	#show tutorial
	pass

func StartSelectingCharacters():
	emit_signal("enterSelectMode");

func SelectCharacter(index:int):
	currentPlayableCharacter = mapController.amountOfCharactersInMap[index];

func SelectNextCharacterToFuze():
	if(currentPlayableCharacter != null):
		currentPlayableCharacter.HideSelectedCharacter();
	currentIndexToSelectCharacter += 1;

func _on_TextureButton_pressed() -> void:
	get_tree().quit();
