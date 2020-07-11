extends Node2D

onready var mainScene := get_tree().get_root().get_node("MainScene");
onready var animPlayer:AnimationPlayer = get_node("AnimationPlayer");

var _tween:Tween = Tween.new();

#var canSelectCharacter = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
	
	

func _fuseWithCharacter(characterToFuse):
	mainScene.currentPlayableCharacter = characterToFuse;
	_tween.interpolate_property(
		self,
		"global_transform.origin",
		self.global_transfrom.origin,
		characterToFuse.global_transform.origin,
		1,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	);
	_tween.start();

func DefuseWithCharacter():
	if(mainScene.currentPlayableCharacter == null):return
	mainScene.currentPlayableCharacter = null

func _on_Area2D_area_entered(area: Area2D) -> void:
	var body = area.get_parent();
	if(body is Character):
		_fuseWithCharacter(body);
