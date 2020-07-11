extends Node
class_name Character

onready var mainScene := get_tree().get_root().get_node("MainScene");
onready var selectIndicator := get_node("SelectIndicator");

var characterSpeed = Variables.characterBaseSpeed;
var _delayTillFreakOut:Timer = Timer.new();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(_delayTillFreakOut);
	_delayTillFreakOut.wait_time = Variables.delayTillCharacterFreakOut;
	_delayTillFreakOut.connect("timeout", self, "_freakOut");


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func GetReadyToFreakOut():
	_delayTillFreakOut.start();

func _freakOut():
	GetReadyToFreakOut();

func SlowCharacterDown():
	characterSpeed = Variables.characterSlowBaseSpeed;

func SpeedCharaterUp():
	var characterSpeed = Variables.characterBaseSpeed;

func KillCharacter():
	#play character death
	mainScene.LoseGame();

func DisplaySelectedCharacter():
	selectIndicator.ShowIndicator();

func HideSelectedCharacter():
	selectIndicator.HideIndicator();
