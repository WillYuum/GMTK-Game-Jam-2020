extends Control

signal enterSelectMode;

onready var camera :Camera2D = get_node("Camera2D");
onready var mapController := get_node("MainMap");
onready var ghost := get_node("MainPlayer");
onready var bgmMusic := get_node("BGM");
onready var winAudio := get_node("WinAudio");
onready var loseAudio := get_node("LoseAudio");

#UI
onready var UI := get_node("UI");
onready var loseScreen := UI.get_node("LoseScreen");
onready var winScreen := UI.get_node("WinScreen");
onready var gameEndScreen := UI.get_node("GameEndScreen");

var currentLevel = 1;
var gameIsOn = false;

#for character selection
var currentPlayableCharacter = null;
var currentIndexToSelectCharacter = 0;
var canSelectCharacters = false;

#Win variables
var amountOfCharactersInMap;
var amountCharacterTaken;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gameEndScreen.hide();
	loseScreen.hide();
	winScreen.hide();
	bgmMusic.play(0);
#	yield(get_tree().create_timer(2), "timeout");
#	connect()
	StartGame();


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func StartGame():
	ghost.controlledChar = null
	gameIsOn = true;
	mapController.ReadyUpMap();
	currentSelectedCharacter = null;
	amountCharacterTaken = 0;
	amountOfCharactersInMap = mapController.GetAmountOfCharactersInMap();
	yield(get_tree().create_timer(2), "timeout");
	ghost.EnterGhostToMap();
	pass

func WinGame():
	gameIsOn = false;
	winAudio.play(0);
	currentLevel += 1;
	winScreen.show();
	yield(get_tree().create_timer(2),"timeout");
	winScreen.hide();
	StartGame();

func LoseGame():
	gameIsOn = false;
	loseScreen.show();
	LeavetFuzeMode();
	yield(get_tree().create_timer(2),"timeout");
	loseScreen.hide();
	RestartGame();

func RestartGame():
	mapController.RestartMapEntities();
	StartGame();

func _input(event: InputEvent) -> void:
	HandleMovingPlayableCharacter(event);

var currentSelectedCharacter;
func HandleMovingPlayableCharacter(event:InputEvent):
	if(canSelectCharacters == false): return;
	if event is InputEventKey and event.is_pressed() and event.scancode == KEY_TAB:
		SelectNextCharacterToFuze();
	if event is InputEventKey and event.is_pressed() and event.scancode == KEY_E:
		GhostFuzeWithChar();

func GhostFuzeWithChar():
	ghost.FuseWithCharacter(currentSelectedCharacter);

func GhostTookCharacter():
	amountCharacterTaken += 1;
	_checkIfWonGame();

func _checkIfWonGame():
	if(amountCharacterTaken >= mapController.amountOfCharactersInMap.size()):
		WinGame();

func SelectCharacterFirstTime():
	#show tutorial
	pass

func StartSelectingCharacters():
	emit_signal("enterSelectMode");

func SelectCharacter(index:int):
	mapController.GetAmountOfCharactersInMap();
	if(mapController.amountOfCharactersInMap.size() <= 1): return
	currentSelectedCharacter = mapController.amountOfCharactersInMap[index];
	if(currentSelectedCharacter.isControlled):
		index += 1;
		if(index >= mapController.amountOfCharactersInMap.size()):
			index = 0;
		currentSelectedCharacter = mapController.amountOfCharactersInMap[index]
	currentSelectedCharacter.DisplaySelectedCharacter();


func SelectNextCharacterToFuze():
	mapController.GetAmountOfCharactersInMap();
	if(mapController.amountOfCharactersInMap.size() <= 1): return
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



func _on_Button_pressed() -> void:
	get_tree().reload_current_scene();

func _on_Button2_pressed() -> void:
	get_tree().quit();

func StartPanickingCharacters():
	for character in mapController.amountOfCharactersInMap:
		character.GetReadyToFreakOut();
