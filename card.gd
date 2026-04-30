extends CharacterBody2D

var rng = RandomNumberGenerator.new()
var change = true
var suits = ["Hearts", "Diamonds", "Clubs", "Spades"]

func _ready():
	random_card()

func _process(delta: float) -> void:
	pass
	

func random_card() -> void:
	randomize()
	var value = rng.randi_range(0, 12)
	randomize()
	
	if change:
		$CardSelector.play(suits.pick_random())
		$CardSelector.pause()
		$CardSelector.set_frame(value)
		$CardSelector.scale = Vector2(1, 1)
		$Timer.start()
		change = false

func hide_card() -> void:
	$CardSelector.play("Hidden")
	$CardSelector.pause()
	$CardSelector.scale = Vector2(0.1, 0.1)

func _on_timer_timeout() -> void:
	change = true
