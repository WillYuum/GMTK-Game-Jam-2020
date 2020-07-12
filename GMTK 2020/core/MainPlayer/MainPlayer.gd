extends Node2D

onready var mainScene := get_tree().get_root().get_node("MainScene");
onready var animPlayer:AnimationPlayer = get_node("AnimationPlayer");

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
	yield(get_tree().create_timer(animPlayer.get_animation("GhostEntry").length), "timeout");
	if(Variables.firstTimePlaying):
		mainScene.SelectCharacterFirstTime();
	mainScene.EnterFuzeMode();
	
	

func FuseWithCharacter(characterToFuse):
	if(controlledChar != null):
		controlledChar.isControlled = false;
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
	_canFuzeWithCharacter = false
	mainScene.currentPlayableCharacter = characterToFuse;
	yield(get_tree().create_timer(Variables.ghostSwitchCharacterSpeed), "timeout");
	controlledChar = characterToFuse;
	controlledChar.isControlled = true;
	mainScene.SelectNextCharacterToFuze()
	_canFuzeWithCharacter = true
	self.hide();

func DefuseWithCharacter():
	if(mainScene.currentPlayableCharacter == null):return
	mainScene.currentPlayableCharacter = null

#func _on_Area2D_area_entered(area: Area2D) -> void:
#	var body = area.get_parent();
#	if(body is Character):
#		_fuseWithCharacter(body);
