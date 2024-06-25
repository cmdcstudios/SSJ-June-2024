extends Control

@onready var the_tool_tip: TextureButton = $TheToolTip
@export var item1: Item
@export var item2: Item
@export var item_tooltip: PackedScene
var _stored_item: Item
#@onready var the_tool_tip = $TheToolTip

var _tooltip: Tooltip = null

const TOOLTIP_ITSELF = preload("res://Data/Items/71_tooltip_itself.tres") as Item
# The game will end and some dialogue will need to play afterwards. 
@onready var bsod = $BSOD

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_stored_item = item1
	the_tool_tip.hide()
	
	#await DialogueManager.show_dialogue_balloon(load("res://Dialogue/ending_dialogue.dialogue"), "sold_the_game").tree_exited
	print("done")

func _on_the_tool_tip_pressed() -> void:
	print("bsod")
	if (_tooltip == null or TooltipInfo.tooltips.size() >= 1):
		if TooltipInfo.tooltips.size() > 0: TooltipInfo.tooltips[0].queue_free()
		TooltipInfo.tooltips.pop_front()
		_tooltip = item_tooltip.instantiate() as Tooltip
		print(_tooltip.get_child(0).position)
		#_tooltip.get_child(0).global_position = global_position - Vector2(800, 0)
		TooltipInfo.tooltips.append(_tooltip)
		_tooltip.load_item_info(_stored_item)
		self.add_child(_tooltip)
	if (!SignalManager.item_sold.is_connected(_on_item_sold)):
		print("Tooltip connected!")
		SignalManager.item_sold.connect(_on_item_sold)
	pass # Replace with function body.	
	#DialogueManager.show_dialogue_balloon(load("res://Dialogue/final.dialogue"), "start")

#func _on_tree_exited():
	#print("done")
	#the_tool_tip.show()


func _on_bsod_pressed():
	print("bsod")
	if (_tooltip == null or TooltipInfo.tooltips.size() >= 1):
		if TooltipInfo.tooltips.size() > 0: TooltipInfo.tooltips[0].queue_free()
		TooltipInfo.tooltips.pop_front()
		_tooltip = item_tooltip.instantiate() as Tooltip
		print(_tooltip.get_child(0).position)
		#_tooltip.get_child(0).global_position = global_position - Vector2(800, 0)
		TooltipInfo.tooltips.append(_tooltip)
		_tooltip.load_item_info(_stored_item)
		self.add_child(_tooltip)
	if (!SignalManager.item_sold.is_connected(_on_item_sold)):
		print("Tooltip connected!")
		SignalManager.item_sold.connect(_on_item_sold)
	pass # Replace with function body.


func _on_item_sold(money_amount: int, item_sold: Item) -> void:
	if (item_sold.id == 72):
		the_tool_tip.show()
		_stored_item = item2
		bsod.queue_free()
	if (item_sold.id == 71):
		the_tool_tip.queue_free()
		get_tree().quit()
		#await DialogueManager.show_dialogue_balloon(load("res://Dialogue/ending_dialogue.dialogue"), "sold_the_game").tree_exited
		#DialogueManager.show_dialogue_balloon(load("res://Dialogue/final.dialogue"), "start")
		
