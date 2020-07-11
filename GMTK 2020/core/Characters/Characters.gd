extends Node
class_name Character

onready var mainScene := get_tree().get_root().get_node("MainScene");

var characterSpeed = Variables.characterBaseSpeed;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func FreakOut():
	pass

func SlowCharacterDown():
	characterSpeed = Variables.characterSlowBaseSpeed;

func SpeedCharaterUp():
	var characterSpeed = Variables.characterBaseSpeed;

func KillCharacter():
	#play character death
	mainScene.LoseGame();
