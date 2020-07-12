extends Control
#class_name MapController

onready var mainScene = get_tree().get_root().get_node("MainScene");
onready var currentMap := get_node("Map1");

var _rng = RandomNumberGenerator.new()

var amountOfCharactersInMap = [];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func ReadyUpMap():
	SpawnMap();

func GetAmountOfCharactersInMap():
	if(amountOfCharactersInMap.size() > 0):
		amountOfCharactersInMap.clear();
	amountOfCharactersInMap = currentMap.get_node("CharactersInMap").get_children();

func GoToNextMap():
	SpawnMap();

func SpawnMap():
	if(currentMap != null):
		currentMap.queue_free();
	var newMap = Resources.maps[mainScene.currentLevel - 1].instance();
	currentMap = newMap;
	add_child(newMap);

func RestartMapEntities():
	pass


func SelectRandomPositionToMoveTo() -> Position2D:
	var positions = currentMap.get_node("PointToMove").get_children();
	var randInt = _rng.randi_range(0, positions.size()-1);
	return positions[randInt];
