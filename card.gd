extends CharacterBody2D

var rng = RandomNumberGenerator.new()
var change = true

func _ready():
	random_card()

func _process(delta: float) -> void:
	pass
	

func random_card() -> void:
	randomize()
	var value = rng.randi_range(0, 12)
	randomize()
	var suit = rng.randi_range(1,4)
	
	# Clubs, Diamonds, Hearts, Spades = 1, 2, 3, 4
	if change:
		match suit:
			1:
				suit = "Clubs"
			2:
				suit = "Diamonds"
			3:
				suit = "Hearts"
			4:
				suit = "Spades"
			
		
		$CardSelector.play(suit)
		$CardSelector.pause()
		$CardSelector.set_frame(value)
		$Timer.start()
		change = false


func _on_timer_timeout() -> void:
	change = true
