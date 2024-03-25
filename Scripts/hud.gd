extends Control

func _on_moneycase_item_collected():
	$CenterContainer/briefcasecount.text = global.apple_count
