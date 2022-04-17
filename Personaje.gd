extends KinematicBody2D

const acceleration = 70
const max_speed = 320

var speed = 10
var salto_speed = 450
var gravity = 22


var maxjump = 2
var doble_salto = 550 
var salto = 0
var suelo = true


var velocity = Vector2.ZERO

func _physics_process(_delta):
	move()
	jump()
	velocity = move_and_slide(velocity, Vector2(0,-1))

func move():
	velocity.y += gravity

	if Input.is_action_pressed("ui_down"):
		$Sprite.animation = "danio"
		
	else:
		if Input.is_action_pressed("ui_right"):
			velocity.x = min(velocity.x + acceleration, max_speed)
			$Sprite.flip_h = false

		elif Input.is_action_pressed("ui_left"):
			velocity.x = max(velocity.x - acceleration, -max_speed)
			$Sprite.flip_h = true
		else:
			velocity.x = 0
		if suelo:
			if velocity.x == 0:
				$Sprite.animation = "quieto"
			elif velocity.x > 0 or velocity.x < 0:
				$Sprite.animation = "caminar"

func jump():
	if is_on_floor():
		salto = 0
		suelo = true

	if (Input.is_action_just_pressed("ui_up") && salto < maxjump):
		suelo = false
		if salto == 0:
			$Sprite.animation = "salto"
			velocity.y -= salto_speed
			salto+=1
		elif salto ==1:
			$Sprite.animation = "doble_salto"
			velocity.y -=doble_salto
			salto+=1

	if !is_on_floor():

		if velocity.y > 1:
			$Sprite.animation = "quieto"
