class @Frame
  constructor: (urlSource, scene) ->
    @urlSource = urlSource
    @scene = scene
    @initializeFrame()

  fetchImage: ->
    @url = @urlSource()
    img = new Image();
    img.onload = =>
      console.log(img.width + 'x' + img.height)
      @mesh.material.diffuseTexture = new BABYLON.Texture(@url , @scene)
      if img.height > img.width
        @mesh.material.diffuseTexture.vScale = img.width / img.height
      else
        @mesh.material.diffuseTexture.uScale = img.height / img.width
    img.src = @url

  initializeFrame: ->
    @mesh = BABYLON.Mesh.CreatePlane("Frame", 10, @scene)

    @mesh.position = new BABYLON.Vector3(30,0,20)
    @mesh.rotation.y = 1.57
    @mesh.material = new BABYLON.StandardMaterial("texture1", @scene)
    @mesh.material.diffuseTexture = new BABYLON.Texture("/ultra/1.jpg" , @scene)
    # @scene.executeWhenReady =>
    #   console.log @mesh.material.diffuseTexture.getSize()
    @fetchImage()
    

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

  zoomAndPan: ->
    animationKeys = [{ frame: 0, value: 1 }, { frame: 15, value: 1 }, { frame: 100, value: 0.5 }]
    zoomAnimationU = new BABYLON.Animation(
      "tutoAnimation", "uScale", 15,
      BABYLON.Animation.ANIMATIONTYPE_FLOAT,
      BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT);
    zoomAnimationV = new BABYLON.Animation(
      "tutoAnimation", "vScale", 15,
      BABYLON.Animation.ANIMATIONTYPE_FLOAT,
      BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT);
    zoomAnimationU.setKeys animationKeys
    zoomAnimationV.setKeys animationKeys
    @mesh.material.diffuseTexture.animations.push(zoomAnimationU);
    @mesh.material.diffuseTexture.animations.push(zoomAnimationV);
    @zoomAnimation = @scene.beginAnimation(@mesh.material.diffuseTexture, 0, 100, false);

  moveToPosition: (position) ->
    @position = position
    if position == -3
      @animation.stop() if @animation
      @mesh.position = new BABYLON.Vector3(25,0,20)
      @mesh.rotation.y = 1.57
      @mesh.material.alpha = 0.2
      @mesh.material.diffuseTexture.vScale = 1
      @mesh.material.diffuseTexture.uScale = 1
      @mesh.material.diffuseTexture = new BABYLON.Texture(@urlSource(), @scene)
    else if position == -2
      @moveTo 15, 15, 0.5
      @mesh.material.alpha = 0.4
    else if position == -1
      @mesh.material.alpha = 0.7
      @moveTo 10, 15, 0.4
    else if position == 0
      @moveTo 0, 5, 0
      @mesh.material.alpha = 1
      # @zoomAndPan()
    else if position == 1
      # @animation.stop() if @animation
      # @mesh.material.diffuseTexture.uScale = 0.5
      # @mesh.material.diffuseTexture.vScale = 0.5
      # @animation.restart() if @animation
      # @animation
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