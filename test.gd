extends Node2D
var card_scene: PackedScene = preload("res://card.tscn")
var suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
var dealer = [[],[]] # first list is for current hand, second is for all values within the hand you play for deal breakers
var player = [[],[]]
var middle = []
var hand = []
var p_value = 0
var d_value = 0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		setup()
		#print("\n" + "Player" + "\n")
		var best_hand = check_hand(player)
		
		match best_hand:
			"flush":
				p_value = 9
				#print("Player has a flush!")
				#print_all_values(player[1])
			"high":
				p_value = 2
		
		#print("\n" + "Dealer" + "\n")
		best_hand = check_hand(dealer)
		
		match best_hand:
			"flush":
				d_value = 9
				#print("Dealer has a flush!")
				#print_all_values(dealer[1])
			"high":
				d_value = 2
func _ready() -> void:
	setup()
	print("\n" + "Player" + "\n")
	check_hand(player)
	
	#print("\n" + "Dealer" + "\n")
	#check_hand(dealer)
	
		
func setup() -> void:
	var card_pos = $"Player cards".get_children()
	
	player = [[],[]]
	dealer = [[],[]]
	middle = []
	
	for i in 2:
		var card = card_scene.instantiate() as Node2D
		card.position = card_pos[i].position
		$"Player cards".add_child(card)
		player[0].append(card)
		
	card_pos = $"Dealer cards".get_children()
	for i in 2:
		var card = card_scene.instantiate() as Node2D
		card.position = card_pos[i].position
		$"Dealer cards".add_child(card)
		dealer[0].append(card)
	
	card_pos = $"The Middle".get_children()
	for i in 5:
		var card = card_scene.instantiate() as Node2D
		card.position = card_pos[i].position
		$"The Middle".add_child(card)
		middle.append(card)
	
func check_hand(char_hand) -> String: # char hand is the hand of the player you want to check
	print("unshuffled middle + player's hand")
	hand = char_hand[0] + middle
	
	
	var flush = is_flush(hand, char_hand)
	var straight = is_straight(hand, char_hand)
	if flush:
		return "flush"
	return "high"

func is_flush(hand_to_check, og_hand) -> bool: # hand to check is the combo of the middle and a player's hand, og_hand is a player's hand
	for suit in suits:
		var biggest_cards = []
		var suit_for_flush = 0
		for card in hand_to_check:
			if suit == card.get_suit():
				suit_for_flush += 1
				biggest_cards.append(card)
		if suit_for_flush > 4:
			og_hand[1] = biggest_cards
			return true
		biggest_cards = []
	return false
	
func is_straight(hand_to_check, og_hand) -> bool: # 
	for i in range(len(hand_to_check)):
		#print("I Cycle -> ", i)
		var cur = hand_to_check[i].get_value()
		for j in range(i, len(hand_to_check)):
			#print("J iter -> ", j)
			if cur + 1 == hand_to_check[j].get_value():
				print("Next value == cur + 1")
				print(cur, " >>> ", hand_to_check[j].get_value())
			elif cur - 1 == hand_to_check[j].get_value():
				print("Next value == cur - 1")
				print(cur, " <<< ", hand_to_check[j].get_value())
	return false
	
func is_any_pair() -> int:
	return false

func print_all_suits(arr) -> void: # use arrays with card objects only!
	for i in arr:
		print(i.get_suit())

func print_all_values(arr) -> void: # use arrays with card objects only!
	for i in arr:
		print(i.get_value())
