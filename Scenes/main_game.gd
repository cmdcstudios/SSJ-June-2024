extends Node3D


var current_customer : CustomerResource
var item_sold : Item


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.item_sold.connect(_on_item_sold)
	SignalManager.customer_entered.connect(_on_customer_entered)


func evaluate_item():
	var approved : bool = false
	for ia in item_sold.item_attributes:
		for ip in current_customer.item_preference:
			if ia == ip:
				approved = true 
	if approved:
		print("Customer is happy!")
	else:
		print("I'm not sure they liked that...")


func _on_item_sold(price : int, item : Item):
	print(item.name)
	item_sold = item
	evaluate_item()


func _on_customer_entered(customer : CustomerResource):
	print(customer.name)
	current_customer = customer
