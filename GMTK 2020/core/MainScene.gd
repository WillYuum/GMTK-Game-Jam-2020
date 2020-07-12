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
var canSelectCharacters = false;

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
	mapController.ReadyUpMap();
	currentSelectedCharacter = null;
	amountCharacterTaken = 0;
	amountOfCharactersInMap = mapController.GetAmountOfCharactersInMap();
	yield(get_tree().create_timer(2), "timeout");
	ghost.EnterGhostToMap();
	pass

func WinGame():
	currentLevel += 1;
	StartGame();

func LostGame():
	LeavetFuzeMode();
	RestartGame();

func RestartGame():
	mapController.RestartMapEntities();

func _input(event: InputEvent) -> void:
	HandleMovingPlayableCharacter(event);

var currentSelectedCharacter;
func HandleMovingPlayableCharacter(event:InputEvent):
	if(canSelectCharacters == false): return;
	if event is InputEventKey and event.is_pressed() and event.scancode == KEY_TAB:
		SelectNextCharacterToFuze();
	if event is InputEventKey and event.is_pressed() and event.scancode == KEY_E:
		ghost.FuseWithCharacter(currentSelectedCharacter);


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
	currentSelectedCharacter = mapController.amountOfCharactersInMap[index];
	if(currentSelectedCharacter.isControlled):
		index += 1;
		if(index >= mapController.amountOfCharactersInMap.size()):
			index = 0;
		currentSelectedCharacter = mapController.amountOfCharactersInMap[index]
	currentSelectedCharacter.DisplaySelectedCharacter();


func SelectNextCharacterToFuze():
	if(currentSelectedCharacter != null):
		currentSelectedCharacter.HideSelectedCharacter();
	currentIndexToSelectCharacter += 1;
	
	if(currentIndexToSelectCharacter >= mapController.amountOfCharactersInMap.size()):
		currentIndexToSelectCharacter = 0;
	
	SelectCharacter(currentIndexToSelectCharacter);

func _on_TextureButton_pressed() -> void:
	get_tree().quit();

func EnterFuzeMode():
	canSelectCharacters = true;
	SelectCharacter(currentIndexToSelectCharacter);

func LeavetFuzeMode():
	canSelectCharacters = false;
