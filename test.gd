extends Node2D
var card_scene: PackedScene = preload("res://card.tscn")
var suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
var dealer = []
var player = []
var middle = []
var hand = []

func _ready() -> void:
	setup()
	check_hand(player)
		
func setup() -> void:
	var card_pos = $"Player cards".get_children()
	
	for i in 2:
		var card = card_scene.instantiate() as Node2D
		card.position = card_pos[i].position
		$"Player cards".add_child(card)
		var suit_to_value = [card.get_suit(), card.get_value() + 1]
		player.append(suit_to_value)
		
	card_pos = $"Dealer cards".get_children()
	for i in 2:
		var card = card_scene.instantiate() as Node2D
		card.position = card_pos[i].position
		$"Dealer cards".add_child(card)
		var suit_to_value = [card.get_suit(), card.get_value() + 1]
		dealer.append(suit_to_value)
	
	card_pos = $"The Middle".get_children()
	for i in 5:
		var card = card_scene.instantiate() as Node2D
		card.position = card_pos[i].position
		$"The Middle".add_child(card)
		var suit_to_value = [card.get_suit(), card.get_value() + 1]
		middle.append(suit_to_value)

func check_hand(h) -> void: # h is the hand of the player you want to check
	for i in middle:
		i[0] = "Hearts"
	hand = [h, middle]
	var flush = is_flush(h)
	if flush:
		print("Has flush")

func is_flush(h) -> bool:
	var player_has_flush = false
	var same_suit = 0
	for i in suits:
		var suit_for_flush = i
		for x in hand:
			if i == x[0]:
				same_suit += 1
		for x in h:
			if String(x[0]) == suit_for_flush:
				player_has_flush = true
		if same_suit >= 5 and player_has_flush:
			return true
	return false
	
func is_straight() -> bool:
	return false
	
func is_any_pair() -> bool:
	return false
