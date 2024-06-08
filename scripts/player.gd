extends Area2D
signal hit


@export var speed = 100
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed('dance_button'):
		$AnimatedSprite2D.play('dance')
		return
	if Input.is_action_pressed('dance2_button'):
		$AnimatedSprite2D.play('dance2')
		return
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed('move_left'):
		velocity.x -=1
	if Input.is_action_pressed('move_right'):
		velocity.x +=1
	if Input.is_action_pressed('jump'):
		velocity.y -=2
		$AnimatedSprite2D.play('jump')
		return
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	



func _on_body_entered(body):
	hide() # Replace with function body.
	hit.emit()
	$CollisionShape2D.set_deferred('disabled', true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
