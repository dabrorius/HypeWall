class @BrickRow
  bricksLeft: []
  bricksRight: []

  constructor: (scene, x, y) ->
    @scene = scene
    @x = x
    @y = y

  addLeft: (newBrick) ->
    for brick in @bricksLeft
      brick.mesh.position.x -= newBrick.width
    @bricksLeft.push newBrick
    newBrick.mesh.position.x = @x - newBrick.width / 2
    newBrick.mesh.position.y = @y