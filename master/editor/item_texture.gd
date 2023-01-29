extends TextureRect

export(PackedScene) var this_scene;

onready var edit_cursor = get_node("/root/editor_root/editor_object");
onready var cursor_sprite = edit_cursor.get_node("Sprite");

func ready():
# warning-ignore:return_value_discarded
	connect("gui_input", self, "_item_clicked");
	pass;
	
func _item_clicked(event):
	if (event is InputEvent):
		if(event.is_action_pressed("mb_left")):
			edit_cursor.current_item = this_scene;
			cursor_sprite.texture = texture;
	pass;
