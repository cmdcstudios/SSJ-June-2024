extends Control
class_name CustomerStager

# TO-DO Script is getting large, consider refactoring and breaking debugger into it's own scene

@export var queue_resource : CustomerQueue

@onready var spawn_point = $SpawnPoint
@onready var buttons : VBoxContainer = $VBoxContainer
@onready var customer_queue : Array[CustomerResource] = queue_resource.customer_queue

var item_sold : Item
var customer = load("res://Scenes/customer.tscn")
var current_customer : Customer
var next_customer : Customer
# timer_length is the transition time between customers
var timer_length : float = 1.0


func _ready() -> void:
	# TO-DO refactor so debugger mode off is default state, not set on ready
	debugger_deactivate()
	SignalManager.item_sold.connect(_on_item_sold)


func begin_new_queue(queue : CustomerQueue) -> void:
	customer_queue = queue.customer_queue
	new_customer()


func prestage_customer(customer_data : CustomerResource) -> void:
	next_customer = customer.instantiate()
	next_customer.customer_name = customer_data.name
	next_customer.customer_greeting = customer_data.greeting
	next_customer.sprite_texture = customer_data.sprite
	next_customer.item_preference = customer_data.item_preference
	next_customer.customer_dialogue = customer_data.dialogue


func new_customer() -> void:
	free_customer()
	if customer_queue.is_empty() == false:
		var customer_data = customer_queue.pop_front() as CustomerResource
		prestage_customer(customer_data)
		current_customer = next_customer
		spawn_point.add_child(current_customer)
		DialogueManager.show_dialogue_balloon(customer_data.dialogue, "start")
		SignalManager.customer_entered.emit(customer_data)
	else:
		# TO-DO pass message to DialogueManager & trigger EOD
		SignalManager.end_day.emit()


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
		# TO-DO trigger DialogueManager message "Customer left"
	else:
		# TO-DO trigger DialogueManager message "No customers
		pass

func evaluate_item():
	# Flag for item preference match
	var approved : bool = false
	

	# Check item attributes and customer preferences for any matches
	for ia in item_sold.item_attributes:
		if current_customer != null:
			for ip in current_customer.item_preference:
				if ia == ip:
					approved = true 
		else:
			"No customer, sell to the nothing"
	
	# If matches, customer is happy
	if approved:
		await DialogueManager.show_dialogue_balloon(current_customer.customer_dialogue, "happy").tree_exited
		await get_tree().create_timer(timer_length).timeout
		free_customer()
		await get_tree().create_timer(timer_length).timeout
		new_customer()
		
	else:
		await DialogueManager.show_dialogue_balloon(current_customer.customer_dialogue, "unhappy").tree_exited
		await get_tree().create_timer(timer_length).timeout
		free_customer()
		await get_tree().create_timer(timer_length).timeout
		new_customer()

func _on_item_sold(price : int, item : Item):
	#print(item.name)
	item_sold = item
	evaluate_item()


# ----------- DEBUGGER UI ----------- 


func _on_cool_customer_pressed():
	customer_queue.push_front(load("res://Data/Customers/CustomerCool.tres"))
	new_customer()


func _on_cute_customer_pressed():
	customer_queue.push_front(load("res://Data/Customers/CustomerCute.tres"))
	new_customer()
	

func _on_flashy_customer_pressed():
	customer_queue.push_front(load("res://Data/Customers/CustomerFlashy.tres"))
	new_customer()


func _on_plain_customer_pressed():
	customer_queue.push_front(load("res://Data/Customers/CustomerPlain.tres"))
	new_customer()


func _on_solid_customer_pressed():
	customer_queue.push_front(load("res://Data/Customers/CustomerSolid.tres"))
	new_customer()


func _on_indifferent_customer_pressed():
	customer_queue.push_front(load("res://Data/Customers/CustomerIndifferent.tres"))
	new_customer()


func _on_free_customer_pressed():
	free_customer()


func _on_next_customer_pressed():
	new_customer()
