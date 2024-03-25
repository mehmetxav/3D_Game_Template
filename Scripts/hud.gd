extends Control

func _on_moneycase_item_collected():
	$CenterContainer/briefcasecount.text = str(global.apple_count) 
