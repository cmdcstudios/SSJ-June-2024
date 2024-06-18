extends Control

@export var queue_resource : CustomerQueue

@onready var spawn_point = $SpawnPoint
@onready var text_box : Label = $Panel/Label
@onready var buttons : VBoxContainer = $VBoxContainer
@onready var customer_queue : Array[CustomerResource] = queue_resource.customer_queue


var customer = load("res://Scenes/customer.tscn")
var cool_attribute = load("res://ItemAttributes/ia_cool.tres")
var current_customer : Customer
var next_customer : Customer


func _ready() -> void:
	# TO-DO refactor so debugger mode off is default state, not set on ready
	debugger_deactivate()
	SignalManager.start_day.connect(_on_start_day)


func prestage_customer(customer_data : CustomerResource) -> void:
	next_customer = customer.instantiate()
	next_customer.customer_name = customer_data.name
	next_customer.customer_greeting = customer_data.greeting
	next_customer.sprite_texture = customer_data.sprite
	next_customer.item_preference = customer_data.item_preference


func new_customer(customer_data : CustomerResource) -> void:
	free_customer()
	if customer_queue.is_empty() == false:
		prestage_customer(customer_data)
		current_customer = next_customer
		spawn_point.add_child(current_customer)
		text_box.text = "A customer walks in...\n" + current_customer.customer_greeting
		SignalManager.customer_entered.emit(customer_data)
	else:
		text_box.text = "That was the last customer of the day!"


func debugger_activate() -> void:
	add_child(buttons)


func debugger_deactivate() -> void:
	remove_child(buttons)


# Refactor to take array as arg
func spawn_customer(preference : ItemAttribute):
	pass


func free_customer():
	if current_customer != null:
		current_customer.queue_free()
		text_box.text = "The customer left."
	else:
		text_box.text = "There's no customers here..."
	

func _on_start_day() -> void:
	new_customer(customer_queue.pop_front())


# ----------- DEBUGGER UI ----------- 


func _on_cool_customer_pressed():
	new_customer(load("res://Data/Customers/CustomerCool.tres"))


func _on_cute_customer_pressed():
	new_customer(load("res://Data/Customers/CustomerCute.tres"))
	

func _on_flashy_customer_pressed():
	new_customer(load("res://Data/Customers/CustomerFlashy.tres"))


func _on_plain_customer_pressed():
	new_customer(load("res://Data/Customers/CustomerPlain.tres"))


func _on_solid_customer_pressed():
	new_customer(load("res://Data/Customers/CustomerSolid.tres"))


func _on_indifferent_customer_pressed():
	new_customer(load("res://Data/Customers/CustomerIndifferent.tres"))


func _on_free_customer_pressed():
	free_customer()


func _on_next_customer_pressed():
	new_customer(customer_queue.pop_front())
