extends CharacterBody3D
class_name PlayerWZ

@export var sprite : AnimatedSprite3D
enum SheetType {ONEDIR, TWODIR, FOURDIR, ONEFRAME}
enum CameraType {ROOM, NMP, FIXED}
@export var sheet : SheetType = SheetType.FOURDIR
@export var camera : CameraType = CameraType.ROOM

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var dir = "Down"
var state = "idle"

func _process(delta: float) -> void:
	var cam3d = get_viewport().get_camera_3d()
	var unproj = cam3d.unproject_position(global_position)
	match camera:
		CameraType.ROOM:
			if unproj.x > Game.res.x - (Game.res.x/3):
				cam3d.position = Vector3(cam3d.position.x + 0.05, cam3d.position.y, cam3d.position.z)
				
			if unproj.x < Game.res.x/3:
				cam3d.position = Vector3(cam3d.position.x - 0.05, cam3d.position.y, cam3d.position.z)
				
		CameraType.NMP:
			if unproj.x > Game.res.x - (Game.res.x/3):
				cam3d.position = Vector3(cam3d.position.x + 0.05, cam3d.position.y, cam3d.position.z)
				
			if unproj.x < Game.res.x/3:
				cam3d.position = Vector3(cam3d.position.x - 0.05, cam3d.position.y, cam3d.position.z)
			
			if position.z - cam3d.position.z < -7:
				cam3d.position.z -= 0.05
			
			if position.z - cam3d.position.z > -4:
				cam3d.position.z += 0.05		

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	if input_dir.x > 0:
		dir = "Right"
	elif input_dir.x < 0:
		dir = "Left"
		
	if input_dir.y > 0:
		dir = "Down"
	elif input_dir.y < 0:
		dir = "Up"
		
		
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		state = "walk"
	else:
		velocity.x = move_toward(velocity.x, 0, 0.3)
		velocity.z = move_toward(velocity.z, 0, 0.3)
		state = "idle"

	if sheet == SheetType.TWODIR:
		match dir:
			"Up":
				dir = "Right"
			"Down":
				dir = "Left"
				
	if sheet == SheetType.ONEDIR or sheet == SheetType.ONEFRAME:
		dir = "Down"
		
	if sheet == SheetType.ONEFRAME:
		state = "idle"
		
	if sprite.animation != state + dir:
		sprite.animation = state + dir
	
	if !sprite.is_playing():
		sprite.play()
	
	move_and_slide()
