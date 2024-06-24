extends Node

var money: int

enum GameFlags {
	TUTORIAL,
	NORMAL,
	SELLABLE,
	ENDGAME,
	CUSTOMER_ENTER,
	CUSTOMER_EXIT
}

enum States {
	TUTORIAL,
	NORMAL,
	CUSTOMER_ENTER,
	CUSTOMER_EXIT
}

var current_game_state: GameFlags = GameFlags.SELLABLE
var inventorys: Array[Inventory] = []
var day_resources: Array[DayResource] = []

func _ready() -> void:
	dir_contents("res://Data/Inventory")
	dir_days_contents("res://Data/Days")

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
				inventorys.push_front(ResourceLoader.load("res://Data/Inventory/" + file_name))
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


func dir_days_contents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				day_resources.append(ResourceLoader.load("res://Data/Days/" + file_name))
				#print(inventorys)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func get_dayresource(day: int) -> DayResource:
	#check for out of bounds index on the array before calling
	if day > day_resources.size() - 1:
		return null
	else:
		return day_resources[day]
		
		

