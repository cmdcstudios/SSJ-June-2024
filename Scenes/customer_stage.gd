extends Control


@onready var spawn_point = $SpawnPoint

var customer = load("res://Scenes/customer.tscn")

var cool_attribute = load("res://ItemAttributes/ia_cool.tres")


func spawn_customer(preference : ItemAttribute):
	var new_customer = customer.instantiate()
	new_customer.item_preference = preference
	spawn_point.add_child(new_customer)


# Called when the node enters the scene tree for the first time.
func _ready():
	$Customer.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_summon_button_pressed():
	spawn_customer(cool_attribute)
