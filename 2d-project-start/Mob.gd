extends CharacterBody2D

var minimum_drop_chance = 0.2
var maximum_drop_chance = 0.4
var health_drop = preload("res://health_pack.tscn")

var health = 2
@onready var player = get_node("/root/Game/Player")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()

func _ready():
	%Slime.play_walk()

func take_damage():
	health -= 1
	%Slime.play_hurt()
	if health == 0:
		queue_free()
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position 

	if drop_the_health() and health == 0:
		drop_health_packs()

func drop_the_health():
	var orange = randf()
	return orange >= minimum_drop_chance and orange <= maximum_drop_chance

func drop_health_packs():
	var drop_instance = health_drop.instantiate()
	drop_instance.position = position
	get_parent().add_child(drop_instance)
