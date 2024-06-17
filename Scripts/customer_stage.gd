extends Control


@onready var spawn_point = $SpawnPoint
@onready var text_box : Label = $Panel/Label

var customer = load("res://Scenes/customer.tscn")
var cool_attribute = load("res://ItemAttributes/ia_cool.tres")
var current_customer : Customer

func _ready() -> void:
	SignalManager.item_pref.connect(_on_item_preference_sold)

func spawn_customer(preference : ItemAttribute):
	free_customer()
	current_customer = customer.instantiate()
	current_customer.item_preference = preference
	spawn_point.add_child(current_customer)
	print(current_customer.item_preference.name)


func free_customer():
	if current_customer != null:
		current_customer.queue_free()
		text_box.text = "The customer left."
	else:
		text_box.text = "There's no customers here..."


func _on_cool_customer_pressed():
	spawn_customer(load("res://ItemAttributes/ia_cool.tres"))
	text_box.text = "A cool customer walked in!"


func _on_cute_customer_pressed():
	spawn_customer(load("res://ItemAttributes/ia_cute.tres"))
	text_box.text = "A cute customer walked in!"
	

func _on_flashy_customer_pressed():
	spawn_customer(load("res://ItemAttributes/ia_flashy.tres"))
	text_box.text = "A flashy customer walked in!"


func _on_plain_customer_pressed():
	spawn_customer(load("res://ItemAttributes/ia_plain.tres"))
	text_box.text = "A plain customer walked in!"


func _on_solid_customer_pressed():
	spawn_customer(load("res://ItemAttributes/ia_solid.tres"))
	text_box.text = "A solid customer walked in!"


func _on_free_customer_pressed():
	free_customer()

func _on_item_preference_sold(item_attr: ItemAttribute):
	pass

