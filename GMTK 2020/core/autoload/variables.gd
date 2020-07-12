extends Node

#tutorial stuff
var firstTimePlaying = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#Characters
var characterBaseSpeed = 300;
var characterSlowBaseSpeed = 200;
var delayTillCharacterFreakOut = 4;

#Obstacles(Spike)
var timeSpikeStaysUp = 2;
var timeToShowSpike = 4;

#Character switching
var ghostSwitchCharacterSpeed = 0.25;


var delayTillStopFreakOut = 0.5;
