extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var maps = [
	preload("res://gameObjects/Maps/Map1.tscn"),
	preload("res://gameObjects/Maps/Map2.tscn"),
	preload("res://gameObjects/Maps/Map3.tscn"),
	preload("res://gameObjects/Maps/Map4.tscn"),
	preload("res://gameObjects/Maps/Map5.tscn"),
	preload("res://gameObjects/Maps/Map6.tscn"),
]


var char1Sprite ={
	"control": preload("res://assets/Characters/Character1/3- front.png");
	"freakOut":preload("res://assets/Characters/Character1/3- front.png")
} 
