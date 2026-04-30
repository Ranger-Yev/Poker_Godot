extends Node2D

var rng = RandomNumberGenerator.new()
var change = true
var suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
var value = -1
var suit = "undefined"


func _ready():
	random_card()

func _process(delta: float) -> void:
	pass
	

func random_card() -> void:
	randomize()
	value = rng.randi_range(0, 12)
	randomize()
	
	if change:
		suit = suits.pick_random()
		$CardSelector.play(suit)
		$CardSelector.pause()
		$CardSelector.set_frame(value)
		$CardSelector.scale = Vector2(1, 1)
		$Timer.start()
		change = false

func hide_card() -> void:
	$CardSelector.play("Hidden")
	$CardSelector.pause()
	$CardSelector.scale = Vector2(0.1, 0.1)

func get_value() -> int:
	return value

func _on_timer_timeout() -> void:
	change = true
