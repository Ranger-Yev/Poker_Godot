extends Node2D

var rng = RandomNumberGenerator.new()
var change = true
var suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
var value = -1
var suit = "undefined"
@onready var selector = $CardSelector
@onready var time = $Timer


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
		selector.play(suit)
		selector.pause()
		selector.set_frame(value)
		selector.scale = Vector2(1, 1)
		time.start()
		change = false

func hide_card() -> void:
	selector.play("Hidden")
	selector.pause()
	selector.scale = Vector2(0.1, 0.1)

func get_value() -> int:
	return value + 1

func get_suit() -> String:
	return suit

func set_value(val) -> void:
	value = val
	selector.set_frame(value)

func _on_timer_timeout() -> void:
	change = true
