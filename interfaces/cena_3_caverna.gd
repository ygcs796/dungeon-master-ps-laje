extends Control

var quantidade_cliques : int = 0
var decisao_1 : int
@onready var texto_dialogo = $BarraDialogo/PainelTexto/TextoDialogo
@onready var imagem_dialogo = $BarraDialogo/ImagemPersonagem

var texto_ladina = [
	"Então, o que a gente vê?",
	"Certo... E?",
	"Ele é ok.",
	"Uuh. Nós definitivamente vamos te seguir, baby.",
	"Cara, tá zoando com a gente?"
]

var texto_mago = [
	"Vamos pegar um deles.",
	"Tô gostando desse cara.",
	"Pessoal. Eu vi no mapa. É uma caverna. Tem dois caminhos. Vamos pegar qualquer um deles."
]

var texto_guerreiro = [
	"É, vamos por esse aqui.",
	"É, ele é bom.",
	"Com certeza.",
	"Você tá bem? Se você não quiser mestrar, nós entendemos."
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BarraDialogo.visible = false
	$HeroiPerdido.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func mudanca_dialogo(texto, imagem = null) -> void:

	if(imagem != null):
		imagem_dialogo.texture = load("res://assets/npc/{imagem}_falando.png".format({"imagem": imagem}))
	texto_dialogo.text = texto


func _on_botao_opcao_1_pressed() -> void:
	$SeletorEscolhas.visible = false
	$BarraDialogo.visible = true
	decisao_1 = 1
	_on_botao_texto_pressed()


func _on_botao_opcao_2_pressed() -> void:
	$SeletorEscolhas.visible = false
	$BarraDialogo.visible = true
	decisao_1 = 2
	_on_botao_texto_pressed()


func _on_botao_opcao_3_pressed() -> void:
	$SeletorEscolhas.visible = false
	$BarraDialogo.visible = true
	decisao_1 = 3
	_on_botao_texto_pressed()


func _on_botao_opcao_4_pressed() -> void:
	$SeletorEscolhas.visible = false
	$BarraDialogo.visible = true
	decisao_1 = 4
	_on_botao_texto_pressed()


func _on_botao_texto_pressed() -> void:
	
	if(decisao_1 == 1):
		dialogo_1()
	elif(decisao_1 == 2):
		dialogo_2()
	elif(decisao_1 == 3):
		$HeroiPerdido.visible = true
		dialogo_3()
	elif(decisao_1 == 4):
		Master.contador_silencio += 1
		dialogo_4()

func dialogo_1():
	quantidade_cliques += 1
	match quantidade_cliques:
		
		1:
			mudanca_dialogo(texto_ladina[1], "rogue")
		2:
			mudanca_dialogo(texto_mago[0], "mage")
		3:
			mudanca_dialogo(texto_guerreiro[0], "warrior")
		4:
			$FadeOutTela.visible = true
			$FadeOutTela/FadeOutAnimacao.play("fade_out")
			
			await $FadeOutTela/FadeOutAnimacao.animation_finished
			
			get_tree().change_scene_to_file("res://interfaces/cena_4_combate.tscn")
	
func dialogo_2():
	quantidade_cliques += 1
	match quantidade_cliques:
		
		1:
			mudanca_dialogo(texto_mago[1], "mage")
		2:
			mudanca_dialogo(texto_guerreiro[1], "warrior")
		3:
			mudanca_dialogo(texto_ladina[2], "rogue")
		4:
			$FadeOutTela.visible = true
			$FadeOutTela/FadeOutAnimacao.play("fade_out")
			
			await $FadeOutTela/FadeOutAnimacao.animation_finished
			
			get_tree().change_scene_to_file("res://interfaces/cena_4_combate.tscn")
				
func dialogo_3():
	quantidade_cliques += 1
	match quantidade_cliques:
		
		1:
			mudanca_dialogo(texto_ladina[3], "rogue")
		2:
			mudanca_dialogo(texto_guerreiro[2], "warrior")
		3:
			$FadeOutTela.visible = true
			$FadeOutTela/FadeOutAnimacao.play("fade_out")
			
			await $FadeOutTela/FadeOutAnimacao.animation_finished
			
			get_tree().change_scene_to_file("res://interfaces/cena_4_combate.tscn")
			
func dialogo_4():
	quantidade_cliques += 1
	match quantidade_cliques:
		
		1:
			mudanca_dialogo(texto_ladina[4], "rogue")
		2:
			mudanca_dialogo(texto_guerreiro[3], "warrior")
		3:
			mudanca_dialogo(texto_mago[2], "mage")
		4:
			$FadeOutTela.visible = true
			$FadeOutTela/FadeOutAnimacao.play("fade_out")
			
			await $FadeOutTela/FadeOutAnimacao.animation_finished
			
			get_tree().change_scene_to_file("res://interfaces/cena_4_combate.tscn")
