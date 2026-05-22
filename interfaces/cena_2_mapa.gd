extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func iniciar_barra_de_progresso():
	
	var barra = $ProgressBar
	barra.value = 0
	
	for i in range(1, 8):
		
		await get_tree().create_timer(1.0)
		barra.value = i
		
