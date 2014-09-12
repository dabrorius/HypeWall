class @BrickRow

  constructor: (scene, x, y) ->
    @scene = scene
    @x = x
    @y = y
    @bricksLeft = []
    @bricksRight = []
    @side = 1

  clearBricks: ->
    for brick in @bricksRight
      @clearBrick brick
    for brick in @bricksLeft
      @clearBrick brick
    @bricksLeft = []
    @bricksRight = []

  addBrick: (newBrick) ->
    if @side == 1
      relatedBricks = @bricksRight
      adjacentBricks = @bricksLeft
    else 
      relatedBricks = @bricksLeft
      adjacentBricks = @bricksRight

    for brick in relatedBricks
      @moveBrickToSide brick, newBrick

    relatedBricks.push newBrick
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
    newBrick.mesh.animations.push(positionAnimation)

    rotationAnimation = new BABYLON.Animation( 
        "pAnim", "rotation.y", 15,
        BABYLON.Animation.ANIMATIONTYPE_FLOAT,
        BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT )
    rotationAnimation.setKeys([
      { frame: 0, value: (-Math.PI * 2/3) * @side }, 
      { frame: 15, value: 0 }
    ]);

    alphaAnimation = new BABYLON.Animation( 
        "pAnim", "material.alpha", 15,
        BABYLON.Animation.ANIMATIONTYPE_FLOAT,
        BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT )
    alphaAnimation.setKeys([
      { frame: 0, value: 0 }, 
      { frame: 10, value: 1 }
    ]);
    newBrick.mesh.animations.push(rotationAnimation)
    newBrick.mesh.animations.push(alphaAnimation)

    @scene.beginAnimation(newBrick.mesh, 0, 100, false);

    @side *= -1

  moveBrickToSide: (brick, newBrick) ->
    positionAnimation = new BABYLON.Animation( 
      "pAnim", "position", 15,
      BABYLON.Animation.ANIMATIONTYPE_VECTOR3,
      BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT )
    positionAnimation.setKeys([
      { frame: 0, value: brick.mesh.position }, 
      { frame: 15, value: new BABYLON.Vector3(brick.mesh.position.x + newBrick.width * @side, brick.mesh.position.y, brick.mesh.position.z ) }
    ]);
    brick.mesh.animations = [positionAnimation]
    @scene.beginAnimation(brick.mesh, 0, 15, false)
    brick.mesh.material.alpha = 0.7

    @scene.beginAnimation(brick.mesh, 0, 25, false)

  clearBrick: (brick) ->
    rotationAnimation = new BABYLON.Animation( 
      "pAnim", "position.z", 15,
      BABYLON.Animation.ANIMATIONTYPE_FLOAT,
      BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT )
    rotationAnimation.setKeys([
      { frame: 0, value: brick.mesh.position.z }, 
      { frame: 5, value: -0.7 }
    ]);

    alphaAnimation = new BABYLON.Animation( 
        "pAnim", "material.alpha", 15,
        BABYLON.Animation.ANIMATIONTYPE_FLOAT,
        BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT )
    alphaAnimation.setKeys([
      { frame: 0, value: 1 }, 
      { frame: 5, value: 0 }
    ]);
    brick.mesh.animations = [rotationAnimation,alphaAnimation]
    @scene.beginAnimation(brick.mesh, 0, 15, false);


