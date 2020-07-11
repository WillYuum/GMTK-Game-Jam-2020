extends Node2D

onready var mainScene := get_tree().get_root().get_node("MainScene");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Area2D_area_entered(area: Area2D) -> void:
	var body = area.get_parent();
	if(body is Character):
		mainScene.GhostTookCharacter();
