class_name Player
extends Node

var game_inventory:Inventory = Inventory.new()


@onready var mouse_area: Area2D = $MouseArea


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_inventory = GameManager.get_inventory(0)


func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		mouse_area.position = event.position
	if (event.is_action_pressed("ui_down")):
		print(game_inventory.get_inventory_contents())

func on_item_pickup(item:Item):
	print("Item added: " + item.name)
	game_inventory.add_item(item)

func check_day(inventory: Inventory):
	pass
