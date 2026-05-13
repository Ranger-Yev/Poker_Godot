extends Node2D
var card_scene: PackedScene = preload("res://card.tscn")
var suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
var dealer = []
var player = []
var middle = []
var hand = []
var p_value = 0
var d_value = 0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		setup()
		print("\n" + "Player" + "\n")
		check_hand(player)
		
		print("\n" + "Dealer" + "\n")
		check_hand(dealer)

func _ready() -> void:
	setup()
	print("\n" + "Player" + "\n")
	check_hand(player)
	
	print("\n" + "Dealer" + "\n")
	check_hand(dealer)
	
		
func setup() -> void:
	var card_pos = $"Player cards".get_children()
	
	player = []
	dealer = []
	middle = []
	
	for i in 2:
		var card = card_scene.instantiate() as Node2D
		card.position = card_pos[i].position
		$"Player cards".add_child(card)
		player.append(card)
		
	card_pos = $"Dealer cards".get_children()
	for i in 2:
		var card = card_scene.instantiate() as Node2D
		card.position = card_pos[i].position
		$"Dealer cards".add_child(card)
		dealer.append(card)
	
	card_pos = $"The Middle".get_children()
	for i in 5:
		var card = card_scene.instantiate() as Node2D
		card.position = card_pos[i].position
		$"The Middle".add_child(card)
		middle.append(card)
	
func check_hand(h) -> void: # h is the hand of the player you want to check
	hand = h + middle
	var flush = is_flush(h)
	if flush:
		print("Has flush")

func is_flush(h) -> bool:
	for suit in suits:
		var suit_for_flush = 0
		for card in h:
			if suit == card.get_suit():
				suit_for_flush += 1
		if suit_for_flush > 4:
			return true 
	return false
	
func is_straight() -> bool:
	return false
	
func is_any_pair() -> bool:
	return false

func print_all_suits(h) -> void:
	for i in h:
		print(i.get_suit())
