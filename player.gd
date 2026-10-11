extends CharacterBody2D

@onready var animationsprite = $AnimatedSprite2D

const SPEED = 150.0
const JUMP_VELOCITY = -200.0

var haveSword = true
var swordAdd = "";


func _physics_process(delta: float) -> void:
	if haveSword == true: swordAdd = "_sword"
	else: swordAdd = ""
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
				
	
	if Input.is_action_just_pressed("attack"): $AnimatedSprite2D.play("attack")
	if $AnimatedSprite2D.animation == "attack" and $AnimatedSprite2D.is_playing():
		velocity.x = move_toward(velocity.x, 0, SPEED)
		move_and_slide() 
		return
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	# Rotation
	if Input.is_action_just_pressed("left"):
		$AnimatedSprite2D.flip_h=true
		
	elif Input.is_action_just_pressed("right"):
		$AnimatedSprite2D.flip_h=false
		
	# Movement
	if direction:
		velocity.x = direction * SPEED
		animationsprite.play("running")
	if direction:
		velocity.x = direction * SPEED
		animationsprite.play("running")
		
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animationsprite.play("idle"+swordAdd)

	move_and_slide()


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "attack":
		$AnimatedSprite2D.play("idle")
