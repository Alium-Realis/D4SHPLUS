extends Node2D

var can_place = true;
onready var level = get_node("/root/editor_root/level");

var current_item;

func _ready():
	pass

func _process(delta):
	global_position = get_global_mouse_position();
	
	if (current_item != null and can_place and Input.is_action_just_pressed("mb_left")):
		var item_instance = current_item.instance();
		level.add_child(item_instance);
		item_instance.global_position = global_position;
