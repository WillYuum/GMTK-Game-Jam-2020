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

var freakOutDirection = Vector2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	HandleMovingCharacter(delta);
	if(isFreakingOut):
		move_and_collide(freakOutDirection * characterSpeed * delta);

func GetReadyToFreakOut():
	_delayTillFreakOut.start();

func _freakOut():
	if(isControlled):return;
	print("freak out")
#	var positionToMoveTo = mainScene.mapController.SelectRandomPositionToMoveTo();
	var randAngle = _rng.randf_range(0, 360.0);
	pointToMoveTo.get_parent().rotation = randAngle;
	isFreakingOut = true;
	freakOutDirection = (pointToMoveTo.global_transform.origin - self.global_transform.origin);
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

var up = Vector2.UP;
var down = Vector2.DOWN;
var left = Vector2.LEFT;
var right = Vector2.RIGHT;

var velocity;
var speed;
func HandleMovingCharacter(delta):
	if(isControlled == false): return;
	freakOutDirection = Vector2();
	var isMoving = Input.is_action_pressed("moveUp") or Input.is_action_pressed("moveRight") or Input.is_action_pressed("moveLeft") or Input.is_action_pressed("moveDown");
	var direction = Vector2();
	if(isMoving):
		speed = characterSpeed;
		if(Input.is_action_pressed("moveUp")):
			direction += up;
		elif(Input.is_action_pressed("moveDown")):
			direction += down;
		if(Input.is_action_pressed("moveLeft")):
			direction += left;
		elif(Input.is_action_pressed("moveRight")):
			direction += right;
		
	else:
		speed = 0;
	
	velocity = speed * direction.normalized() * delta
	move_and_collide(velocity)
	
	
