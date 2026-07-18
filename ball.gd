extends CharacterBody2D

const SPEED = 300.0

func _ready():
	var direction = Vector2(randf_range(-0.5, 0.5), randf_range(0.5, 1)).normalized()
	velocity = direction * SPEED

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)

	if collision:
		print("collided")
		if collision.get_collider().has_method("hit"):
			collision.get_collider().hit()
			velocity = velocity.bounce(collision.get_normal())
			velocity *= 1.05
			print("collided with target")
			print(velocity)
		elif collision.get_collider() is CharacterBody2D:
			var direction = (global_position - collision.get_collider().global_position).normalized()
			var speed = velocity.length()
			velocity = direction * speed

			print("collided with paddle")
			print(velocity)
		else:
			velocity = velocity.bounce(collision.get_normal())

func _init():
	pass
