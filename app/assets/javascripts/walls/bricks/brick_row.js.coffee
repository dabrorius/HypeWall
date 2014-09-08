class @BrickRow
  bricksLeft: []
  bricksRight: []
  side: 1

  constructor: (scene, x, y) ->
    @scene = scene
    @x = x
    @y = y

  addBrick: (newBrick) ->
    if @side == 1
      relatedBricks = @bricksRight
    else 
      relatedBricks = @bricksLeft

    for brick in relatedBricks
      positionAnimation = new BABYLON.Animation( 
        "pAnim", "position", 15,
        BABYLON.Animation.ANIMATIONTYPE_VECTOR3,
        BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT )
      positionAnimation.setKeys([
        { frame: 0, value: brick.mesh.position }, 
        { frame: 15, value: new BABYLON.Vector3(brick.mesh.position.x + newBrick.width * @side, brick.mesh.position.y,0) }
      ]);
      brick.mesh.animations.push(positionAnimation)
      @scene.beginAnimation(brick.mesh, 0, 15, false);

      # brick.mesh.position.x -= newBrick.width
    relatedBricks.push newBrick
    newBrick.mesh.position.x = @x + (newBrick.width * @side) / 2
    newBrick.mesh.position.y = @y
    newBrick.mesh.position.z = 100

    positionAnimation = new BABYLON.Animation( 
        "pAnim", "position", 15,
        BABYLON.Animation.ANIMATIONTYPE_VECTOR3,
        BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT )
    positionAnimation.setKeys([
      { frame: 0, value: newBrick.mesh.position }, 
      { frame: 15, value: new BABYLON.Vector3(newBrick.mesh.position.x, newBrick.mesh.position.y,0) }
    ]);
    newBrick.mesh.animations.push(positionAnimation)
    @scene.beginAnimation(newBrick.mesh, 0, 15, false);

    @side *= -1


