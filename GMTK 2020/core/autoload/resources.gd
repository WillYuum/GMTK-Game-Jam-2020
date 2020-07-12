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
	"control": preload("res://assets/Characters/Character1/3- front.png"),
	"freakOut":preload("res://assets/Characters/Character1/GMTK - -20.png")
} 
var char2Sprite ={
	"control": preload("res://assets/Characters/Character2/2- front.png"),
	"freakOut":preload("res://assets/Characters/Character2/GMTK - -21.png")
}

var char3Sprite ={
	"control": preload("res://assets/Characters/Character3/4- front.png"),
	"freakOut":preload("res://assets/Characters/Character3/GMTK - -19.png")
}

var char4Sprite ={
	"control": preload("res://assets/Characters/Character4/1- front.png"),
	"freakOut":preload("res://assets/Characters/Character4/GMTK - -22.png")
} 
