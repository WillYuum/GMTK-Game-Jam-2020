extends Control
class_name MapController

onready var mainScene:MainScene = get_tree().get_root().get_node("MainScene");
onready var currentMap := get_node("Map1");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func GoToNextMap():
	if(currentMap != null):
		currentMap.queue_free();
	SpawnMap();

func SpawnMap():
	var newMap = Resources.maps[mainScene.currentLevel].instance();
	add_child(newMap);

func RestartMapEntities():
	pass
