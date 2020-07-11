extends Control

onready var camera :Camera2D = get_node("Camera2D");


#UI
onready var UI := get_node("UI");


var currentLevel = 1;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func WinGame():
	currentLevel += 1;
	pass

func LostGame():
	RestartGame();

func RestartGame():
	pass;
