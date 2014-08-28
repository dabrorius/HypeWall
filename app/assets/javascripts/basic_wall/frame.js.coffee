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

    @animation = @scene.beginAnimation(@mesh, 0, 15, true);

  moveToPosition: (position) ->
    @position = position
    if position == -3
      @animation.stop() if @animation
      @mesh.position = new BABYLON.Vector3(25,0,20)
      @mesh.rotation.y = 1.57
      @mesh.material.alpha = 0.2
    else if position == -2
      @moveTo 15, 15, 0.5
      @mesh.material.alpha = 0.4
    else if position == -1
      @mesh.material.alpha = 0.7
      @moveTo 10, 15, 0.4
    else if position == 0
      @moveTo 0, 5, 0
      @mesh.material.alpha = 1
    else if position == 1
      @moveTo -10, 15, -0.4
      @mesh.material.alpha = 0.7
    else if position == 2
      @moveTo -15, 15, -0.5
      @mesh.material.alpha = 0.4
    else if position == 3
      @moveTo -25, 20, -1.57
      @mesh.material.alpha = 0.2

  moveToNextPosition: ->
    @position += 1
    if @position > 3
      @position = -3
    @moveToPosition(@position)