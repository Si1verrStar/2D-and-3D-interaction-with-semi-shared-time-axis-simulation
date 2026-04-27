extends Camera3D


var dragStartMousePosition = Vector2() #Position of the mouse when dragging starts

var dragStartRotation = Vector3() #Rotation of the camera when dragging starts or ends
var moveVelocity = Vector3() #Direction to move the camera in

var dragging: bool = false


func _ready():
	pass


func _process(_delta):
	camera_rotate()
	camera_move()


#Rotate camera with mouse
func camera_rotate():
	if !dragging and Input.is_action_just_pressed("camera_rotate"):
		dragStartRotation = rotation
		dragStartMousePosition = get_viewport().get_mouse_position()
		dragging = true

	if dragging and Input.is_action_just_released("camera_rotate"):
		dragStartRotation = rotation
		dragStartMousePosition = get_viewport().get_mouse_position()
		dragging = false
	
	if dragging:
		var currentMousePosition = get_viewport().get_mouse_position()
		var rotation_offset = 0.005 * Vector3(currentMousePosition.y - dragStartMousePosition.y, currentMousePosition.x - dragStartMousePosition.x, 0)
		rotation = dragStartRotation - rotation_offset


#Move camera with movement keys
func camera_move():
	if Input.is_action_pressed("camera_forward") != Input.is_action_pressed("camera_backwards"):
		if Input.is_action_pressed("camera_forward"):
			moveVelocity.z = -1
		if Input.is_action_pressed("camera_backwards"):
			moveVelocity.z = 1
	else:
		moveVelocity.z = 0

	if Input.is_action_pressed("camera_left") != Input.is_action_pressed("camera_right"):
		if Input.is_action_pressed("camera_left"):
			moveVelocity.x = -1
		if Input.is_action_pressed("camera_right"):
			moveVelocity.x = 1
	else:
		moveVelocity.x = 0

	if Input.is_action_pressed("camera_up") != Input.is_action_pressed("camera_down"):
		if Input.is_action_pressed("camera_up"):
			moveVelocity.y = 1
		if Input.is_action_pressed("camera_down"):
			moveVelocity.y = -1
	else:
		moveVelocity.y = 0
	
	#Adjust movement velocity based on rotation of the camera
	var adjustedMoveVelocity = Vector3()
	adjustedMoveVelocity.x = moveVelocity.x * cos(rotation.y) + moveVelocity.z * sin(rotation.y)
	adjustedMoveVelocity.y = -moveVelocity.z * sin(rotation.x) + moveVelocity.y
	adjustedMoveVelocity.z = -moveVelocity.x * sin(rotation.y) + moveVelocity.z * cos(rotation.y)
	
	position += 0.15 * adjustedMoveVelocity
