extends Node2D
var card_scene: PackedScene = preload("res://card.tscn")
var dealer = []
var player = []
var middle = []

func _ready() -> void:
	var card_pos = $"Player cards".get_children()
	
	for i in 2:
		var card = card_scene.instantiate() as Node2D
		card.position = card_pos[i].position
		var suit_to_value = [card.get_suit(), card.get_value()]
		print(suit_to_value)
		$"Player cards".add_child(card)
		
	card_pos = $"Dealer cards".get_children()
	for i in 2:
		var card = card_scene.instantiate() as Node2D
		card.position = card_pos[i].position
		$"Dealer cards".add_child(card)
	
	card_pos = $"The Middle".get_children()
	for i in 5:
		var card = card_scene.instantiate() as Node2D
		card.position = card_pos[i].position
		$"The Middle".add_child(card)
		
