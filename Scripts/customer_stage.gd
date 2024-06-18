extends Control


@export var CustomerQueue : CustomerQueue


@onready var spawn_point = $SpawnPoint
@onready var text_box : Label = $Panel/Label
@onready var buttons : VBoxContainer = $VBoxContainer


var customer = load("res://Scenes/customer.tscn")
var cool_attribute = load("res://ItemAttributes/ia_cool.tres")
var current_customer : Customer
var next_customer : Customer


func prestage_customer(customer_data : CustomerResource) -> void:
	next_customer = customer.instantiate()
	next_customer
	next_customer.item_preference = customer_data.item_preference


func complete_customer() -> void:
	free_customer()
	prestage_customer(load("res://Data/Customers/CustomerCool.tres"))
	current_customer = next_customer
	spawn_point.add_child(current_customer)
	text_box.text = "The next customer walks in."


func _ready() -> void:
	# TO-DO refactor so debugger mode off is default state, not set on ready
	debugger_deactivate()
	SignalManager.item_pref.connect(_on_item_preference_sold)


func debugger_activate() -> void:
	add_child(buttons)


func debugger_deactivate() -> void:
	remove_child(buttons)


# Refactor to take array as arg
func spawn_customer(preference : ItemAttribute):
	free_customer()
	current_customer = customer.instantiate()
	# Jank.
	current_customer.item_preference.append(preference)
	spawn_point.add_child(current_customer)
	for n in current_customer.item_preference:
		print(n.name)


func free_customer():
	if current_customer != null:
		current_customer.queue_free()
		text_box.text = "The customer left."
	else:
		text_box.text = "There's no customers here..."


# ----------- DEBUGGER UI ----------- 


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


func _on_indifferent_customer_pressed():
	free_customer()
	
	var preferences : Array[ItemAttribute] = [
		load("res://ItemAttributes/ia_cool.tres"),
		load("res://ItemAttributes/ia_cute.tres"),
		load("res://ItemAttributes/ia_flashy.tres"),
		load("res://ItemAttributes/ia_plain.tres"),
		load("res://ItemAttributes/ia_solid.tres")
	]
	
	current_customer = customer.instantiate()
	current_customer.item_preference = preferences
	spawn_point.add_child(current_customer)
	for n in current_customer.item_preference:
		print(n.name)
		
	text_box.text = "This chump will buy anything..."


func _on_next_customer_pressed():
	complete_customer()
