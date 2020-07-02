extends KinematicBody2D

const GRAVITY = 1000
const UP = Vector2(0,-1)
const ACCEL = 4

var vel = Vector2()

export (int) var max_speed = 200
export (int) var max_jump = 500

func _ready():
	pass # Replace with function body.

func _process(_delta): #execute l'action à chaque frame
	pass
	
func _physics_process(delta): #exectue 60 ticks par seconde
	#vel.x = 0 
	vel.y += GRAVITY * delta
	movement_loop()
	
	move_and_slide(vel, UP)
	
func movement_loop():
	var right = Input.is_action_pressed("ui_right") #booléen input vers droite
	var left  = Input.is_action_pressed("ui_left") #booléen input vers gauche
	var dirx  = int(right)-int(left) #soustraction des deux booléens, si résultat = 1 : va vers droite. si -1 : va vers gauche si 0 : va nulle part
	
	if dirx == -1 :
		vel.x = max (vel.x-5,-max_speed)
		$Sprite.flip_h = true #$Sprite appel les composantes des enfants de l'objet auquel est attaché le script
	elif dirx == 1 :
		vel.x = min (vel.x+5,max_speed)
		$Sprite.flip_h = false
	else:
		vel.x = lerp(vel.x,0,0.15) #légère décélération du personnage
	
	var jump = Input.is_action_just_pressed("ui_accept")
	
	if jump == true and is_on_floor():
		vel.y = max_jump
	
	
