extends KinematicBody2D

const ACCELERATION = 500;
const GRAVITY = 500;
const SPEED = 500;
const JUMP_FORCE = 250;
const MAX_SPEED = 500;
const FRICTION = 0.25;
const DASH_FORCE = 200;

onready var animplayer = $AnimationPlayer;
onready var sprite = $Sprite;
onready var dtimer = $dashTimer;

var motion = Vector2.ZERO;
var y_velo = 1;
var face_right = true;

func _physics_process(delta):
	y_velo = 1;
	
	var move_dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left");
	
	var grounded = is_on_floor();
	var walled = is_on_wall();
	
	if grounded && Input.is_action_just_pressed("jump"):
		motion.y = -JUMP_FORCE;
		play_anim("jump");
		$snd_jump.play();
		
	if walled && move_dir != 0:
		y_velo = 0.5;
		if Input.is_action_just_pressed("jump"):
			motion.x += -2 * move_dir * JUMP_FORCE /6;
			motion.y = -JUMP_FORCE;
			play_anim("jump");
			$snd_jump.play();
			
	if Input.is_action_just_pressed("dash") && dtimer.is_stopped():
		motion.x += move_dir * DASH_FORCE;
		dtimer.start();
		$snd_jump.play();
			
	if move_dir != 0:
		motion.x += move_dir * ACCELERATION * delta;
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED);
	else:
		motion.x = lerp(motion.x, 0, FRICTION);
	motion.y += GRAVITY * y_velo * delta;
		
	motion = move_and_slide(motion, Vector2.UP);
		
	if face_right and move_dir < 0:
		flip();
	if !face_right and move_dir > 0:
		flip();
		
	if grounded:
		if move_dir == 0:
			play_anim("idle");
		else:
			play_anim("run");
	else: 
		play_anim("jump");
	
func flip():
	face_right = !face_right;
	sprite.flip_h = !sprite.flip_h;
	
func play_anim(anim_name):
	if animplayer.is_playing() and animplayer.current_animation == anim_name:
		return;
	animplayer.play(anim_name);
	
