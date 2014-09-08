class @BrickRow
  bricksLeft: []
  bricksRight: []

  constructor: (scene, x, y) ->
    @scene = scene
    @x = x
    @y = y

  addRight: (newBrick) ->
    for brick in @bricksRight
      positionAnimation = new BABYLON.Animation( 
        "pAnim", "position", 15,
        BABYLON.Animation.ANIMATIONTYPE_VECTOR3,
        BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT )
      positionAnimation.setKeys([
        { frame: 0, value: brick.mesh.position }, 
        { frame: 15, value: new BABYLON.Vector3(brick.mesh.position.x + newBrick.width, brick.mesh.position.y,0) }
      ]);
      brick.mesh.animations.push(positionAnimation)
      @scene.beginAnimation(brick.mesh, 0, 15, false);

      # brick.mesh.position.x -= newBrick.width
    @bricksRight.push newBrick
    newBrick.mesh.position.x = @x + newBrick.width / 2
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

  addLeft: (newBrick) ->
    for brick in @bricksLeft
      positionAnimation = new BABYLON.Animation( 
        "pAnim", "position", 15,
        BABYLON.Animation.ANIMATIONTYPE_VECTOR3,
        BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT )
      positionAnimation.setKeys([
        { frame: 0, value: brick.mesh.position }, 
        { frame: 15, value: new BABYLON.Vector3(brick.mesh.position.x - newBrick.width, brick.mesh.position.y,0) }
      ]);
      brick.mesh.animations.push(positionAnimation)
      @scene.beginAnimation(brick.mesh, 0, 15, false);

      # brick.mesh.position.x -= newBrick.width
    @bricksLeft.push newBrick
    newBrick.mesh.position.x = @x - newBrick.width / 2
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