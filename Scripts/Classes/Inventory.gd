class_name Inventory
extends Resource

@export var _contents: Array[Item] = []

static var _inv_slots: int = 16
## Adds an item to the inventory.
func add_item(item: Item):
	# add a valid item to the array
	# if it doesn't return an error
	if !item: return "Not a valid item!"
	_contents.append(item)
	
func remove_item(item: Item):
	if !item: return "Not a valid item!"
	_contents.erase(item)

# I don't know if this actually works
func get_item(item: Item):
	if !item: return "Not a valid item"
	return _contents.find(item)

func get_inventory_contents() -> Array[Item]:
	return _contents

func get_slot_number_amount() -> int:
	return _inv_slots
	
func set_slot_number(num_of_slots: int) -> void:
	_inv_slots = num_of_slots

func remove_slot() -> void:
	if (get_slot_number_amount() > 0):
		set_slot_number(get_slot_number_amount() - 1)
# todo: must haves
# - slots (need to have at least 16)

#todo: stretch goals
# - stacks
# - create additional functionalities?
