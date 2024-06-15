extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.item_sold.connect(_on_item_sold)
	
func _on_item_sold(money_amount: int, item_sold:Item) -> void:
	GameManager.money += money_amount
	var money_label = self.get_child(0) as Button
	money_label.text = str(GameManager.money) + "G"
