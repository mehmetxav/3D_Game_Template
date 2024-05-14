extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@export var speed = 3 
@export var patrol_locations : Array[Marker3D]
@export_file var game_over_scene
signal reached_player 

var patrol_index : int = 0
var wait_frame : bool = true
var is_following_player : bool = false

func _ready():
	set_patrol_location()

func set_patrol_location():
	var location = patrol_locations[patrol_index].global_position
	nav_agent.set_target_position(location)

func _physics_process(delta):
	#print(is_following_player)
	# no navigation in the first physics frame
	if wait_frame:
		wait_frame = false
		return
		
	if nav_agent.distance_to_target() < 1 and not is_following_player:
		patrol_index = patrol_index + 1
		if patrol_index >= patrol_locations.size():
			patrol_index = 0
		set_patrol_location()
		return
		
	
	if nav_agent.distance_to_target() < 2 and is_following_player:
		global.apple_count = 0 
		global.has_special_key = false
		get_tree().change_scene_to_file(game_over_scene)
		return

	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed
	velocity = new_velocity
	look_at(current_location + new_velocity)
	move_and_slide()
	
#gets the player location form the nav region
func update_target_location(target_location):
	if not is_following_player:
		return
	nav_agent.set_target_position(target_location)


func _on_playerdetectarea_body_entered(body):
	if $"detect cooldown".time_left > 0:
		return
	is_following_player = true
	$enemy/AnimationPlayer.play("Run")
	$DetectSound.play()
	
	

func _on_playerdetectarea_body_exited(body):
	is_following_player = false
	$enemy/AnimationPlayer.play("Walk_001")
	set_patrol_location()
	$"detect cooldown".start()

func _on_hitbox_body_entered(body):
	queue_free()
