extends CharacterBody2D

@onready var animatedSprite = $AnimatedSprite2D

var direction : Vector2 = Vector2()
var timer = 0
var inConversation = false

func npc1():
	pass

func _ready():
	randomize()
	set_process(true)
	animatedSprite.play("idle")

func choose_random_direction():
	if inConversation:
		return

	var rand_num = randi() % 5

	match rand_num:
		0:
			direction = Vector2(0, -1)
			animatedSprite.play("idle")
		1:
			direction = Vector2(0, 1)
			animatedSprite.play("idle")
		2:
			direction = Vector2(-1, 0)
			animatedSprite.play("idle")
		3:
			direction = Vector2(1, 0)
			animatedSprite.play("idle")
		4:
			direction = Vector2(0, 0)
			animatedSprite.play("idle")
			timer = 0

func read_input():
	if inConversation:
		direction = Vector2(0, 0)
		animatedSprite.play("idle")
		return

	var velocity = direction
	velocity = velocity.normalized()
	set_velocity(velocity * 45)
	move_and_slide()
	velocity = velocity

func startConversation():
	inConversation = true
	direction = Vector2(0, 0)
	animatedSprite.play("idle")
	# Stop any ongoing movement
	set_velocity(Vector2.ZERO)

func endConversation():
	inConversation = false

func _physics_process(delta):
	timer += delta
	
	if inConversation:
		direction = Vector2(0, 0)
		set_velocity(Vector2.ZERO)  # Ensure the NPC is completely still
		return

	if timer > 4.0:
		direction = Vector2(0, 0)
		animatedSprite.play("idle")
		choose_random_direction()
		timer = 0
	
	read_input()
