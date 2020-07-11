extends Control
#class_name MapController

onready var mainScene = get_tree().get_root().get_node("MainScene");
onready var currentMap := get_node("Map1");

var amountOfCharactersInMap = [];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func ReadyUpMap():
	GoToNextMap();

func GetAmountOfCharactersInMap():
	if(amountOfCharactersInMap.size() > 0):
		amountOfCharactersInMap.clear();
	amountOfCharactersInMap = get_node("Map1/CharactersInMap").get_children();

func GoToNextMap():
	if(currentMap != null):
		currentMap.queue_free();
	SpawnMap();

func SpawnMap():
	var newMap = Resources.maps[mainScene.currentLevel - 1].instance();
	add_child(newMap);

func RestartMapEntities():
	pass
