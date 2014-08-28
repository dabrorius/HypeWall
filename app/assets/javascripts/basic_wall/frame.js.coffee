class @Frame
  constructor: (url, scene) ->
    @scene = scene
    @mesh = BABYLON.Mesh.CreatePlane("newImage", 10.0, scene)
    @mesh.position = new BABYLON.Vector3(30,0,20)
    @mesh.rotation.y = 1.57
    @mesh.material = new BABYLON.StandardMaterial("texture1", scene)
    @mesh.material.diffuseTexture = new BABYLON.Texture(url, scene)

  moveTo: (newX, newZ, newRotation) ->
    positionAnimation = new BABYLON.Animation(
      "tutoAnimation", "position", 15,
      BABYLON.Animation.ANIMATIONTYPE_VECTOR3,
      BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT);
    positionAnimation.setKeys([
      { frame: 0, value: @mesh.position }, 
      { frame: 10, value: new BABYLON.Vector3(newX,0,newZ) }
    ]);
    @mesh.animations.push(positionAnimation);

    rotationAnimation = new BABYLON.Animation(
      "tutoAnimation", "rotation.y", 15,
      BABYLON.Animation.ANIMATIONTYPE_FLOAT,
      BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT);
    rotationAnimation.setKeys([
      { frame: 0, value: @mesh.rotation.y },
      { frame: 10, value: newRotation }
    ]);
    @mesh.animations.push(rotationAnimation);

    @scene.beginAnimation(@mesh, 0, 15, true);

  moveToPosition: (position) ->
    @position = position
    if position == -2
      @moveTo 15, 20, 0.5
    else if position == -1
      @moveTo 10, 20, 0.4
    else if position == 0
      @moveTo 0, 10, 0
    else if position == 1
      @moveTo -10, 20, -0.4
    else if position == 2
      @moveTo -15, 20, -0.5

  moveToNextPosition: ->
    @position += 1
    if @position > 2
      @position = -2
    @moveToPosition(@position)