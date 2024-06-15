extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.item_sold.connect(_on_item_sold)
	
func _on_item_sold(money_amount:int) -> void:
	var money_label = self.get_child(0) as Button
	money_label.text = str(money_amount)
  
