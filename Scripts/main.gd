extends Node2D

@onready var dinheirolabel = $UI/Panel2/UI_Grid/Label # (atualiza o HUD, opcional)
@onready var estoquelabel = $UI/Panel2/UI_Grid/Label2

func _ready() -> void:
	updateUI()

func updateUI():
	$UI/Panel2/UI_Grid/Label.text = "$" + str(Global.dinheiro)
	$UI/Panel2/UI_Grid/Label2.text = str(Global.estoque)
	$PC/Monitor/JanelaNavegador/Panel/GridContainer/Quantidade.value
	
func _on_button_pressed() -> void:
	var node = $PC
	var botao = $UI/Panel/HBoxContainer/Button
	var botaoclick = $Control/Sprite2D
	if node.visible:
		node.hide()
		botaoclick.show()
		botao.text = "PC"
		# Mudar ícone/texto se quiser
	else:
		node.show()
		botaoclick.hide()
		botao.text = "Quarto"

func _on_sprite_2d_pressed() -> void:
	if Global.estoque >= 1:
		Global.dinheiro += 150
		Global.estoque -= 1
	updateUI()

func _on_comprar_pressed() -> void:
	var quantidade = int($PC/Monitor/JanelaNavegador/Panel/GridContainer/Quantidade.value)
	var custo_total = quantidade * Global.celular
	if custo_total <= Global.dinheiro:
		Global.dinheiro -= custo_total
		Global.estoque += quantidade
	updateUI()
