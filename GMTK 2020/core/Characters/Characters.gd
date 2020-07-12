extends KinematicBody2D
class_name Character

signal freakOut
signal control

onready var mainScene := get_tree().get_root().get_node("MainScene");
onready var selectIndicator := get_node("SelectIndicator");
onready var pointToMoveTo := get_node("dirs").get_children();

var timer:Timer = Timer.new();

var freekOutSpeed = Variables.freakOutSpeed;
var characterSpeed = Variables.characterBaseSpeed;
var _delayTillFreakOut:Timer = Timer.new();

var isControlled = false;
var isFreakingOut = false;


var _rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_rng.randomize();
	add_child(timer)
	timer.wait_time = Variables.delayTillStopFreakOut;
	add_child(_delayTillFreakOut);
	_delayTillFreakOut.wait_time = Variables.delayTillCharacterFreakOut;
	_delayTillFreakOut.connect("timeout", self, "_freakOut");
	timer.connect("timeout", self, "_stopFreakingOut");

var freakOutDirection = Vector2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(mainScene.gameIsOn == false):return;
	if(mainScene.gameIsOn == false): return;
	if(isControlled):
		HandleMovingCharacter(delta);
		return
	elif(isFreakingOut):
		move_and_collide(freakOutDirection * freekOutSpeed * delta);
		return

func GetReadyToFreakOut():
	yield(get_tree().create_timer(1),"timeout");
	_delayTillFreakOut.start();

func _freakOut():
	if(isControlled):return;
	print("freak out")
	_rng.randomize();
	var dir;
	emit_signal("freakOut")
#	var positionToMoveTo = mainScene.mapController.SelectRandomPositionToMoveTo();
	var randAngle = _rng.randf_range(0, pointToMoveTo.size() -1);
	dir = pointToMoveTo[randAngle];
	isFreakingOut = true;
	freakOutDirection = (dir.global_transform.origin - self.global_transform.origin);
#	GetReadyToFreakOut();

func SlowCharacterDown():
	print("slow player down!!!")
	characterSpeed = Variables.characterSlowBaseSpeed;
	freekOutSpeed = Variables.slowFreakOutSpeed;

func SpeedCharaterUp():
	characterSpeed = Variables.characterBaseSpeed;
	freakOutDirection = Variables.freakOutSpeed;

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
	
	
