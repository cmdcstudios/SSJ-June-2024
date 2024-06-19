extends Node

var money: int

enum GameFlags {
	TUTORIAL,
	NORMAL,
	SELLABLE,
	ENDGAME,
}

var current_game_state: GameFlags = GameFlags.NORMAL
var inventorys: Array[Inventory] = []


func _ready() -> void:
	dir_contents("res://Data/Inventory")
	
func dir_contents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				inventorys.append(ResourceLoader.load("res://Data/Inventory/" + file_name))
				#print(inventorys)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
# Load all of the resources in the inventory folder into an array
# This will enable us to keep track what inventories.
# A nice way is after we go through a day, we pop it off the inventory
# Then when the game checks to see if we have zero in the array
# We can start the endgame and turn on the flags for everything to be sold
func get_inventory(day: int) -> Inventory:
	return inventorys[day]
