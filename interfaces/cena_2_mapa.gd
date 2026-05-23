extends Control

var quantidade_cliques : int = 0
var decisao_1 : int
@onready var texto_dialogo = $BarraDialogo/PainelTexto/TextoDialogo
@onready var imagem_dialogo = $BarraDialogo/ImagemPersonagem

var texto_ladina = [
	"Não me diga...",
	"Sério?",
	"Nada mal",
	"Você realmente não sabe o que dizer, né?"
]

var texto_mago = [
	"Terras Baixas...",
	"Quase Tolkien, né. Gostei",
	"Você já fez isso antes?"
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FadeOutTela.visible = false
	$BarraDialogo.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func iniciar_barra_de_progresso():
	
	var barra = $ProgressBar
	barra.value = 0
	
	for i in range(1, 8):
		
		await get_tree().create_timer(1.0)
		barra.value = i
		

func mudanca_dialogo(texto, imagem = null) -> void:
	
	if(imagem != null):
		imagem_dialogo.texture = load("res://assets/npc/{imagem}.png".format({"imagem": imagem}))
	texto_dialogo.text = texto
	
func _on_botao_opcao_1_pressed() -> void:
	$Botoes.visible = false
	$BarraDialogo.visible = true
	decisao_1 = 1
	_on_botao_texto_pressed()
	

func _on_botao_opcao_2_pressed() -> void:
	$Botoes.visible = false
	$BarraDialogo.visible = true
	decisao_1 = 2
	_on_botao_texto_pressed()
	


func _on_botao_opcao_3_pressed() -> void:
	$Botoes.visible = false
	$BarraDialogo.visible = true
	decisao_1 = 3
	_on_botao_texto_pressed()
	

func _on_botao_texto_pressed() -> void:
	
	if(decisao_1 == 1):
		dialogo_1()
	elif(decisao_1 == 2):
		dialogo_2()
	elif(decisao_1 == 3):
		Master.contador_silencio += 1
		dialogo_3()

func dialogo_1() -> void:
	
	quantidade_cliques += 1
	match quantidade_cliques:
		
		1:
			mudanca_dialogo(texto_ladina[0], "rogue")
		2:
			mudanca_dialogo(texto_ladina[1])
		3:
			$FadeOutTela.visible = true
			$FadeOutTela/FadeOutAnimacao.play("fade_out")
			
			await $FadeOutTela/FadeOutAnimacao.animation_finished
			
			get_tree().change_scene_to_file("res://interfaces/cena_3_caverna.tscn")
func dialogo_2() -> void:
	
	quantidade_cliques += 1
	match quantidade_cliques:
		
		1:
			mudanca_dialogo(texto_ladina[2], "rogue")
		2:
			mudanca_dialogo(texto_mago[0], "mage")
		3:
			mudanca_dialogo(texto_mago[1], "mage")
		4:
			$FadeOutTela.visible = true
			$FadeOutTela/FadeOutAnimacao.play("fade_out")
			
			await $FadeOutTela/FadeOutAnimacao.animation_finished
			
			get_tree().change_scene_to_file("res://interfaces/cena_3_caverna.tscn")

func dialogo_3() -> void:
	
	quantidade_cliques += 1
	match quantidade_cliques:
		
		1:
			mudanca_dialogo(texto_ladina[3], "rogue")
		2:
			mudanca_dialogo(texto_mago[2], "mage")
		3:
			$FadeOutTela.visible = true
			$FadeOutTela/FadeOutAnimacao.play("fade_out")
			
			await $FadeOutTela/FadeOutAnimacao.animation_finished
			
			get_tree().change_scene_to_file("res://interfaces/cena_3_caverna.tscn")
