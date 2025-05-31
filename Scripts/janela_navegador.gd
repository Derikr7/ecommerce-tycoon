extends Panel

var is_dragging := false
var drag_start_position := Vector2() # Caminho para o nó que servirá de limite
var is_maximized := false
var normal_size := Vector2(800, 600)
var normal_position := Vector2(100, 100)

func _ready():
	# Verifica se tem uma barra de título para arrastar (opcional)
	if has_node("Topbar"):
		$Topbar.gui_input.connect(_on_title_bar_input)
	else:
		gui_input.connect(_on_title_bar_input)  # Arrasta por toda a janela

func _on_title_bar_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_dragging = event.pressed
			drag_start_position = get_global_mouse_position() - global_position
			if is_dragging:
				move_to_front()  # Traz a janela para frente ao clicar
	if is_dragging and event is InputEventMouseMotion:
		global_position = get_global_mouse_position() - drag_start_position
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			modulate = Color(1, 1, 1, 0.8)  # Leve transparência
		else:
			modulate = Color(1, 1, 1, 1)  # Opaco novamente
	if is_dragging and event is InputEventMouseMotion:
		var new_pos = get_global_mouse_position() - drag_start_position
		new_pos.x = clamp(new_pos.x, 0, get_viewport_rect().size.x - size.x)
		new_pos.y = clamp(new_pos.y, 0, get_viewport_rect().size.y - size.y)
		global_position = new_pos
		
func _on_maximizar_pressed() -> void:
	if is_maximized:
		# Restaura tamanho normal
		size = normal_size
		position = normal_position
	else:
		# Salva estado atual antes de maximizar
		normal_size = size
		normal_position = position
		
		# Maximiza (usa o tamanho do nó pai ou viewport)
		var parent_rect = get_parent_control().get_rect()
		position = parent_rect.position
		size = parent_rect.size
	
	is_maximized = !is_maximized
