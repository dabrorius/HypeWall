class @BrickRow

  constructor: (scene, x, y) ->
    @scene = scene
    @x = x
    @y = y
    @bricks = []
    @toRemove = []
    @side = 1

  clearBricks: ->
    for brick in @bricks
      @clearBrick brick
    @bricks = []

  addBrick: (newBrick) ->
    for brick in @toRemove
      brick.mesh.dispose()
    @toRemove = []

    @bricks.push newBrick
    margine = 0.01
    newBrick.mesh.position.x = @x + (newBrick.width * @side) / 2 
    newBrick.mesh.position.y = @y
    newBrick.mesh.position.z = newBrick.width 

    positionAnimation = new BABYLON.Animation( 
        "pAnim", "position", 15,
        BABYLON.Animation.ANIMATIONTYPE_VECTOR3,
        BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT )
    positionAnimation.setKeys([
      { frame: 0, value: newBrick.mesh.position }, 
      { frame: 15, value: new BABYLON.Vector3(@x + (newBrick.width * @side) / 2 + (@side * margine), @y,0) }
      { frame: 100, value: new BABYLON.Vector3(@x + (newBrick.width * @side) / 2 + (@side * margine), @y, -0.1) }
    ]);
    rotationAnimation = new BABYLON.Animation( 
        "pAnim", "rotation.y", 15,
        BABYLON.Animation.ANIMATIONTYPE_FLOAT,
        BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT )
    rotationAnimation.setKeys([
      { frame: 0, value: (-Math.PI * 2/3) * @side }, 
      { frame: 15, value: 0 }
    ]);
    alphaAnimation = Animations.createAlphaAnimation()
    alphaAnimation.setKeys([ {frame: 0, value: 0}, {frame: 10, value: 1} ]);

    newBrick.mesh.animations.push(rotationAnimation)
    newBrick.mesh.animations.push(alphaAnimation,positionAnimation,rotationAnimation)

    @scene.beginAnimation(newBrick.mesh, 0, 100, false);
    @side *= -1

  clearBrick: (brick) ->
    @toRemove.push brick
    rotationAnimation = new BABYLON.Animation( 
      "pAnim", "position.z", 15,
      BABYLON.Animation.ANIMATIONTYPE_FLOAT,
      BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT )
    rotationAnimation.setKeys([
      { frame: 0, value: brick.mesh.position.z }, 
      { frame: 5, value: -0.7 }
    ]);

    alphaAnimation = Animations.createAlphaAnimation()
    alphaAnimation.setKeys([ {frame: 0, value: 1}, {frame: 5, value: 0} ]);

    brick.mesh.animations = [rotationAnimation,alphaAnimation]
    @scene.beginAnimation(brick.mesh, 0, 15, false);


