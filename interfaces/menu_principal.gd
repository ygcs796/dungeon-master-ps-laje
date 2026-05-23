extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	print("Iniciar Jogo")
	get_tree().change_scene_to_file("res://main.tscn")


func _on_exit_button_pressed() -> void:
	print("Saiu do jogo")
	get_tree().quit()


func _on_creditos_button_pressed() -> void:
	get_tree().change_scene_to_file("res://interfaces/creditos.tscn")


func _on_teste_batalha_pressed() -> void:
	get_tree().change_scene_to_file("res://interfaces/cena_3_caverna.tscn")
