
extends CharacterBody3D

@export var walk_speed := 6.0
@export var sprint_speed := 10.0
@export var jump_velocity := 5.0

var gravity = 9.8

@onready var pivot = $CameraPivot

func _ready():
    var capsule = CapsuleMesh.new()
    capsule.radius = 0.42
    capsule.height = 1.8
    $Visual.mesh = capsule

    var mat = StandardMaterial3D.new()
    mat.albedo_color = Color.BLUE
    $Visual.material_override = mat

func _physics_process(delta):
    if not is_on_floor():
        velocity.y -= gravity * delta

    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_velocity

    var input_dir = Input.get_vector(
        "move_left", "move_right",
        "move_forward", "move_back"
    )

    var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

    var speed = sprint_speed if Input.is_action_pressed("sprint") else walk_speed

    if direction:
        velocity.x = direction.x * speed
        velocity.z = direction.z * speed
    else:
        velocity.x = move_toward(velocity.x, 0, walk_speed * 5 * delta)
        velocity.z = move_toward(velocity.z, 0, walk_speed * 5 * delta)

    move_and_slide()
    
