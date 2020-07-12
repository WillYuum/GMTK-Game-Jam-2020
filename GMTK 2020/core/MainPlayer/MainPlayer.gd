extends Node2D

onready var mainScene := get_tree().get_root().get_node("MainScene");
onready var animPlayer:AnimationPlayer = get_node("AnimationPlayer");
onready var audioPlayer:AudioStreamPlayer = get_node("Ghost_Woosh");

var _tween:Tween = Tween.new();

var _canFuzeWithCharacter = true;
var controlledChar;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(_tween);


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func EnterGhostToMap():
	self.show();
	animPlayer.play("GhostEntry");
	_canFuzeWithCharacter = false
	yield(get_tree().create_timer(animPlayer.get_animation("GhostEntry").length), "timeout");
	if(Variables.firstTimePlaying):
		mainScene.SelectCharacterFirstTime();
	_canFuzeWithCharacter = true
	mainScene.EnterFuzeMode();
	mainScene.StartPanickingCharacters();
	
	

func FuseWithCharacter(characterToFuse):
	if(_canFuzeWithCharacter == false):return
	mainScene.mapController.GetAmountOfCharactersInMap();
	if(mainScene.mapController.amountOfCharactersInMap.size() <= 1): return
	if(controlledChar != null or is_instance_valid(controlledChar)):
		controlledChar.isControlled = false;
		self.global_transform.origin = controlledChar.global_transform.origin;
	self.show();
	if(_canFuzeWithCharacter == false):return;
	_tween.interpolate_property(
		self,
		"global_transform:origin",
		self.global_transform.origin,
		characterToFuse.global_transform.origin,
		Variables.ghostSwitchCharacterSpeed,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	);
	_tween.start();
	audioPlayer.play(0);
	_canFuzeWithCharacter = false
	mainScene.currentPlayableCharacter = characterToFuse;
	yield(get_tree().create_timer(Variables.ghostSwitchCharacterSpeed), "timeout");
	controlledChar = characterToFuse;
	controlledChar.isControlled = true;
	_canFuzeWithCharacter = true
	self.hide();
	mainScene.SelectNextCharacterToFuze()

func DefuseWithCharacter():
	if(mainScene.currentPlayableCharacter == null):return
	mainScene.currentPlayableCharacter = null

#func _on_Area2D_area_entered(area: Area2D) -> void:
#	var body = area.get_parent();
#	if(body is Character):
#		_fuseWithCharacter(body);
