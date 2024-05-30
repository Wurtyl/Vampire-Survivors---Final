extends Control

var label = Label
var timer = Timer

func _ready():
	label = $Label
	timer = $Timer
	
	timer.start() 

func _process(delta):
	update_label_text()

func update_label_text():
	label.text = str(ceil(timer.time_left))


func _on_timer_timeout():
	preload()
