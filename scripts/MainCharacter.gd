extends CharacterBody2D

@onready var animatedSprite = $AnimatedSprite2D

var direction : Vector2 = Vector2()
var npc1_in_range = false
var npc1 : Node = null  # Reference to the NPC

func _ready():
	# Ensure you have the correct path to your NPC node here
	npc1 = get_node("..../NPC")  # Update this path according to your scene tree structure

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
	elif velocity.x == 0 and velocity.y == 0:
		if direction == Vector2(0, 1):
			animatedSprite.play("idle down")
		elif direction == Vector2(0, -1):
			animatedSprite.play("idle up")
		else:
			animatedSprite.play("idle down")
	if npc1_in_range and npc1:
		if Input.is_action_just_pressed("ui_accept"):
			DialogueManager.show_example_dialogue_balloon(load("res://npc1.dialogue"),"start")
			# Start the conversation with NPC
			npc1.startConversation()

func _on_detection_area_body_entered(body):
	if body.has_method("npc1"):
		npc1_in_range = true
		npc1 = body  # Assign the NPC instance

func _on_detection_area_body_exited(body):
	if body.has_method("npc1"):
		npc1_in_range = false
		# End the conversation with NPC
		body.endConversation()
