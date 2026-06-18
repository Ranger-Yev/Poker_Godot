extends Node2D
var card_scene: PackedScene = preload("res://card.tscn")
var suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
var dealer = [[],[]] # first list is for current hand, second is for all values within the hand you play for deal breakers
var player = [[],[]]
var middle = []
var hand = []
var p_value = 0
var d_value = 0
var ALLVALUES = range(1,14)

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
		#best_hand = check_hand(dealer)
		
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
	hand = char_hand[0] + middle
	
	
	var flush = is_flush(hand, char_hand)
	var straight = is_straight(hand, char_hand)
	
	if flush:
		return "flush"
	return "high"

func is_flush(hand_to_check, og_hand) -> bool: # hand to check is the combo of the middle and a player's hand, og_hand is a player's hand
	# TO DO -> REMAKE THIS USING THE CONVERT ARR METHODS FOR SIMPLICITY/READABILITY SAKE (Should test if it's actually worth it).
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
	
func is_straight(hand_to_check, og_hand) -> bool: # hand to check is the combo of the middle and a player's hand, og_hand is a player's hand
	var int_hand_arr = convert_card_arr_to_int(hand_to_check)
	var straight_arr = []
	var has_ace = false
	
	if 1 in int_hand_arr: 
		has_ace = true
	
	int_hand_arr.sort()
	for i in range(0, len(int_hand_arr)):
		if i != len(int_hand_arr) - 1 && int_hand_arr[i+1] - 1 == int_hand_arr[i]: # checks if the next and current card values are sequential (9 and 10 would return true, 9 and 11 false). Also prevents going past the last index in the array.
			print(int_hand_arr[i], " >>> ", int_hand_arr[i+1])
			if int_hand_arr[i] not in straight_arr: straight_arr.append(int_hand_arr[i]) # adds current card value to arr if it isn't in there already
			if int_hand_arr[i+1] not in straight_arr: straight_arr.append(int_hand_arr[i+1]) # adds next card value to arr if it isn't in there already
	print(has_ace)
	print(straight_arr)
	
	for i in range(0, 14):
		if i < 10:
			print(range(i, i + 5))
		else:
			print(range(i, 14), range(1,(1 + 5) - len(range(i,14))))
	
	return false
	
func is_any_pair() -> int:
	return false

func convert_card_arr_to_int(arr) -> Array:
	var result = []
	for i in arr:
		result.append(i.get_value())
	return result
	
func convert_card_arr_to_str(arr) -> Array:
	var result = []
	for i in arr:
		result.append(i.get_suit())
	return result

func print_all_suits(arr) -> void: # use arrays with card objects only!
	for i in arr:
		print(i.get_suit())

func print_all_values(arr) -> void: # use arrays with card objects only!
	for i in arr:
		print(i.get_value())
