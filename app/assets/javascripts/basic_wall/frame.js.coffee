class @Frame
  @inFocus: null

  constructor: (scene) ->
    @scene = scene
    @mesh = BABYLON.Mesh.CreatePlane("Frame", 10, @scene)
    @mesh.material = new BABYLON.StandardMaterial("texture1", @scene)
    @mesh.material.diffuseTexture = new BABYLON.Texture("/ultra/1.jpg" , @scene)
    
    @background = BABYLON.Mesh.CreatePlane("Frame", 10.03, @scene)
    @background.material = new BABYLON.StandardMaterial("background", @scene)
    @background.material.diffuseColor = new BABYLON.Color3(1, 1, 1)
    @background.parent = @mesh
    @background.position.z = 0.005

    @dimLayer = BABYLON.Mesh.CreatePlane("Frame", 10.03, @scene)
    @dimLayer.material = new BABYLON.StandardMaterial("dimLayer", @scene)
    @dimLayer.material.diffuseColor = new BABYLON.Color3(0, 0, 0)
    @dimLayer.material.alpha = 0
    @dimLayer.parent = @mesh
    @dimLayer.position.z = -0.005
    @dimLayer.position.y = - 5.015
    @dimLayer.scaling.y = 2

    @reflection = BABYLON.Mesh.CreatePlane("Reflection", 10, @scene)
    @reflection.position.y = -10.03
    @reflection.scaling.y = -1
    @reflection.parent = @mesh
    @reflection.material = new BABYLON.StandardMaterial("texture1", @scene)
    @reflection.material.alpha = 0.1
    @reflection.material.backFaceCulling = false
    @reflection.material.diffuseTexture = new BABYLON.Texture("/ultra/1.jpg" , @scene)

    @reflectionBackground = BABYLON.Mesh.CreatePlane("ReflectionBackground", 10.03, @scene)
    @reflectionBackground.material = new BABYLON.StandardMaterial("ReflectionBackground", @scene)
    @reflectionBackground.parent = @mesh
    @reflectionBackground.position.z = 0.01
    @reflectionBackground.position.y = -10.03
    @reflectionBackground.material.diffuseColor = new BABYLON.Color3(0.03,0.03,0.03)

    @fetchImage()

  setDim: (value) ->
    @dimLayer.material.alpha = value

  zoom: ->
    elapsedTime = ( (new Date().getTime()) - @onPositionSince )
    percentPan = elapsedTime / 6000
    @mesh.material.diffuseTexture.uScale = 1 - 0.1 * percentPan
    @mesh.material.diffuseTexture.vScale = 1 - 0.1 * percentPan
    @reflection.material.diffuseTexture.uScale = 1 - 0.1 * percentPan
    @reflection.material.diffuseTexture.vScale = 1 - 0.1 * percentPan

  fetchImage: ->
    @url = ImageSource.getNext()
    img = new Image();
    img.onload = =>
      @mesh.material.diffuseTexture = new BABYLON.Texture(@url , @scene)
      @reflection.material.diffuseTexture = new BABYLON.Texture(@url, @scene)
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
      @mesh.rotation.y = 1.5
      @mesh.material.diffuseTexture.vScale = 1
      @mesh.material.diffuseTexture.uScale = 1
      @fetchImage()
    else if position == -2
      @moveTo 15, 15, 1.5
    else if position == -1
      @moveTo 10, 15, 1.4
    else if position == 0
      Frame.inFocus = this
      @moveTo 0, 5, 0
    else if position == 1
      @moveTo -10, 15, -1.4
    else if position == 2
      @moveTo -15, 15, -1.5
    else if position == 3
      @moveTo -25, 20, -1.5

    switch Math.abs(position)
      when 3 then @setDim(0.8)
      when 2 then @setDim(0.65)
      when 1 then @setDim(0.5)
      when 0 then @setDim(0)

  moveToNextPosition: ->
    newPosition = @position + 1
    if newPosition > 3
      newPosition = -3
    @moveToPosition(newPosition)