extends MarginContainer


signal zoom_in
signal zoom_out


func _on_zoom_in_pressed():
	emit_signal("zoom_in")


func _on_zoom_out_pressed():
	emit_signal("zoom_out")
