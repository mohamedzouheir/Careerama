extends CharacterBody2D

@onready var animatedSprite = $AnimatedSprite2D

var direction : Vector2 = Vector2()

func read_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		direction = Vector2(0, -1)
		
		
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		direction = Vector2(0, 1)
		
		
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		direction = Vector2(-1, 0)
		
		
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		direction = Vector2(1, 0)
		
		
	velocity = velocity.normalized()
	set_velocity(velocity * 100)
	move_and_slide()
	velocity = velocity
	
	
func _physics_process(delta):
	read_input()
	
	if velocity.x > 0:
		animatedSprite.play("walk right") 
	elif velocity.x < 0:
		animatedSprite.play("walk left")
	elif velocity.y > 0:
		animatedSprite.play("walk down")
	elif velocity.y < 0:
		animatedSprite.play("walk up")
	elif velocity.x == 0 && velocity.y == 0:
		if direction == Vector2(0, 1):
			animatedSprite.play("idle down")
		elif direction == Vector2(0, -1):
			animatedSprite.play("idle up")
		else:
			animatedSprite.play("idle down")
