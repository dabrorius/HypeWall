class @Frame
  constructor: (urlSource, scene) ->
    @urlSource = urlSource
    @scene = scene
    @mesh = BABYLON.Mesh.CreatePlane("Frame", 10, @scene)
    @mesh.material = new BABYLON.StandardMaterial("texture1", @scene)
    @mesh.material.diffuseTexture = new BABYLON.Texture("/ultra/1.jpg" , @scene)
    @fetchImage()

  fetchImage: ->
    @url = @urlSource()
    img = new Image();
    img.onload = =>
      @mesh.material.diffuseTexture = new BABYLON.Texture(@url , @scene)
      xScale = img.width / img.height
      yScale = 1

      while (xScale > 1.8)
        xScale *= 0.9
        yScale *= 0.9
        
      @mesh.scaling.x = xScale
      @mesh.scaling.y = yScale
        
    img.src = @url    

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

    @animation = @scene.beginAnimation(@mesh, 0, 15, false);

  moveToPosition: (position) ->
    @onPositionSince = new Date().getTime()
    @position = position
    if position == -3
      @animation.stop() if @animation
      @mesh.position = new BABYLON.Vector3(25,0,20)
      @mesh.rotation.y = 2.57
      @mesh.material.diffuseTexture.vScale = 1
      @mesh.material.diffuseTexture.uScale = 1
      @fetchImage()
    else if position == -2
      @moveTo 15, 15, 1.5
    else if position == -1
      @moveTo 10, 15, 1.4
    else if position == 0
      @moveTo 0, 5, 0
    else if position == 1
      @moveTo -10, 15, -1.4
    else if position == 2
      @moveTo -15, 15, -1.5
    else if position == 3
      @moveTo -25, 20, -2.57
    @mesh.material.alpha = 1 / (Math.abs(position)+1)

  moveToNextPosition: ->
    newPosition = @position + 1
    if newPosition > 3
      newPosition = -3
    @moveToPosition(newPosition)