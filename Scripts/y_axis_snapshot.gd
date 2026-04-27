extends Node3D

var yValue: int = 0 #Value of y (shared time) axis for this snapshot

@onready var Frame1 = $Frame1
@onready var Frame2 = $Frame2
@onready var Frame3 = $Frame3
@onready var Frame4 = $Frame4


func _ready():
	set_sprite()


#Set sprite based on yValue so that the stickman is animated
func set_sprite():
	if yValue % 40 <= 10:
		Frame1.show()
		Frame2.hide()
		Frame3.hide()
		Frame4.hide()
	elif yValue % 40 <= 20:
		Frame1.show()
		Frame2.hide()
		Frame3.hide()
		Frame4.hide()
	elif yValue % 40 <= 30:
		Frame1.show()
		Frame2.hide()
		Frame3.hide()
		Frame4.hide()
	elif yValue % 40 <= 40:
		Frame1.show()
		Frame2.hide()
		Frame3.hide()
		Frame4.hide()
