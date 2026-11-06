
extends Node3D

func _ready():
    create_city()

func create_city():
    var ground = MeshInstance3D.new()
    var floor = BoxMesh.new()
    floor.size = Vector3(200, 1, 200)
    ground.mesh = floor
    ground.position.y = -0.5
    add_child(ground)

    var light = DirectionalLight3D.new()
    light.rotation_degrees = Vector3(-45, 30, 0)
    add_child(light)

    for x in range(-4, 5):
        for z in range(-4, 5):
            if x == 0 and z == 0:
                continue

            var building = MeshInstance3D.new()
            var shape = BoxMesh.new()
            shape.size = Vector3(8, randf_range(8, 30), 8)
            building.mesh = shape
            building.position = Vector3(
                x * 15,
                shape.size.y / 2,
                z * 15
            )
            add_child(building)
