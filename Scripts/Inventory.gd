class_name Inventory

var _contents: Array[Item] = []

func add_item(item: Item):
	# add a valid item to the array
	# if it doesn't return an error
	if !item: return "Not a valid item!"
	_contents.append(item)
	
	pass
	
func remove_item(item: Item):
	# find item in array and remove it
	# if it doesn't exist return an error
	pass
	
func get_item(item: Item):
	# search for item in inventory_array and then return it.
	# if it doesn't exist return an error
	pass

func get_inventory_contents() -> Array[Item]:
	return _contents
