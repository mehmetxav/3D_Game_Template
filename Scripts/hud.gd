extends Control

func _ready():
	$CenterContainer2/Console.text = ""

func _on_moneycase_item_collected():
	$CenterContainer/briefcasecount.text = str(global.apple_count) 


func _on_pickuparea_update_console(message):
	$CenterContainer2/Console.text = message

