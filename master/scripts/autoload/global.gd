extends Node

onready var plr = preload("res://master/scenes/entities/Player.tscn");
onready var current_scene = get_tree().current_scene.name;

var instance
var plr_spawn

func _ready():
	print(current_scene);

func spawn():
	plr_spawn = get_tree().get_root().get_node(current_scene + "/plr_spawn");
	instance = plr.instance();
	add_child(instance);
	instance.global_position = plr_spawn.global_position;
	
