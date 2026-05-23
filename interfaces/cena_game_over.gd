extends Control

func _on_texture_button_button_down() -> void:
	get_tree().change_scene_to_file("res://interfaces/menu_principal.tscn")
