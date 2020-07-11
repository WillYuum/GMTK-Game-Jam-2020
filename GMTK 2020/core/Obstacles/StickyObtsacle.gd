extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Area2D_area_entered(area: Area2D) -> void:
	var body = area.get_parent();
	if(body is Character):
		#call slow character down
		body.SpeedCharaterUp();


func _on_Area2D_area_exited(area: Area2D) -> void:
	var body = area.get_parent();
	if(body is Character):
		#call speed character down
		body.SlowCharacterDown();
