extends Node2D


var _spikeTimer:Timer = Timer.new();
var charactersInRange = [];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(_spikeTimer);
	_spikeTimer.connect("timeout", self, "_showSpike");
	_spikeTimer.wait_time = Variables.timeToShowSpike;
	_spikeTimer.start();


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _showSpike():
	#show spike
	yield(get_tree().create_timer(Variables.timeSpikeStaysUp), "timeout");
	

func _checkIfCharacterInRange():
	if(charactersInRange.size() <= 0): return;
	
	for character in charactersInRange:
		#kill character
		pass

func _addCharacterInRange(character):
	charactersInRange.append(character);


func _removeCharacterInRange(character):
	var selectedCharacter = charactersInRange.find(character);
	if(selectedCharacter != -1):
		charactersInRange.remove(selectedCharacter);

func _on_Area2D_area_entered(area: Area2D) -> void:
	var body = area.get_parent();
	if(body is Character):
		_addCharacterInRange(body)


func _on_Area2D_area_exited(area: Area2D) -> void:
	var body = area.get_parent();
	if(body is Character):
		_removeCharacterInRange(body)
