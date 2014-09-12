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
    newBrick.mesh.animations.push(rotationAnimation)

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
      { frame: 15, value: -2 }
    ]);
    brick.mesh.animations = [rotationAnimation]
    brick.mesh.material.alpha = 0.5
    @scene.beginAnimation(brick.mesh, 0, 15, false);


