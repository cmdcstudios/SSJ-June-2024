class_name Player
extends Node

var game_inventory:Inventory = Inventory.new()
const RAY_LENGTH = 10000
@onready var mouse_area: Area2D = $MouseArea

@onready var sub_viewport_container = $"../SubViewportContainer"
@onready var ui_root = $"../UIRoot"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_inventory = GameManager.get_inventory(0)


func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		mouse_area.position = event.position
	#if (event.is_action_pressed("ui_down")):
		#print(game_inventory.get_inventory_contents())
	
	if TooltipInfo.tooltips.size() == 0 and GameManager.current_game_state == GameManager.GameFlags.SELLABLE:
		if event is InputEventMouseButton and event.pressed and event.button_index == 1:
			print("clicked here")
			var camera3d = $"../SubViewportContainer/SubViewport/Camera3D" as Camera3D
			var space_state = camera3d.get_world_3d().direct_space_state
			var origin = camera3d.project_ray_origin(event.position/sub_viewport_container.stretch_shrink)
			var end = origin + camera3d.project_ray_normal(event.position/sub_viewport_container.stretch_shrink) * RAY_LENGTH
			var query = PhysicsRayQueryParameters3D.create(origin, end)
			query.collide_with_areas = true
			var result = space_state.intersect_ray(query)
			if (result):
				var sellable_item = result["collider"].get_parent().get_parent() as SellableItem
				sellable_item.spawn_tooltip(ui_root)

func _physics_process(delta):
	var mousepos = get_viewport().get_mouse_position() / sub_viewport_container.stretch_shrink
	#print(mousepos)


func on_item_pickup(item:Item):
	print("Item added: " + item.name)
	game_inventory.add_item(item)

func check_day(inventory: Inventory):
	pass


func _on_input_event(camera, event, position, normal, shape_idx):
	print(event)
	if event is InputEventMouseButton and event.pressed and event.button.index == 1:
		print("PIG")
	pass # Replace with function body.
