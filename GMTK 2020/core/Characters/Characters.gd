extends KinematicBody2D
class_name Character

onready var mainScene := get_tree().get_root().get_node("MainScene");
onready var selectIndicator := get_node("SelectIndicator");
onready var pointToMoveTo := get_node("Point/Point2");

var timer:Timer = Timer.new();

var characterSpeed = Variables.characterBaseSpeed;
var _delayTillFreakOut:Timer = Timer.new();

var isControlled = false;
var isFreakingOut = false;

var direction;

var _rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(timer)
	timer.wait_time = Variables.delayTillStopFreakOut;
	add_child(_delayTillFreakOut);
	_delayTillFreakOut.wait_time = Variables.delayTillCharacterFreakOut;
	_delayTillFreakOut.connect("timeout", self, "_freakOut");
	timer.connect("timeout", self, "_stopFreakingOut");
	GetReadyToFreakOut();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(isFreakingOut):
		move_and_collide(direction * characterSpeed * delta);

func GetReadyToFreakOut():
	_delayTillFreakOut.start();

func _freakOut():
	print("freak out")
	var positionToMoveTo = mainScene.mapController.SelectRandomPositionToMoveTo();
	var randAngle = _rng.randf_range(0, 360.0);
	pointToMoveTo.get_parent().rotation = randAngle;
	isFreakingOut = true;
	direction = (pointToMoveTo.global_transform.origin - self.global_transform.origin);
#	GetReadyToFreakOut();

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

func _stopFreakingOut():
	isFreakingOut = false;
