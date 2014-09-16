$ ->
  currentTime = ->
    (new Date()).getTime()

  canvas = document.getElementById "wall_bricks"
  engine = new BABYLON.Engine canvas, true    
  DataSource.initialize()

  state = "show-background"
  stateStartTime = currentTime()
  backgroundDuration = 3000
  wallDuration = 6000

  createScene = ->
    scene = new BABYLON.Scene(engine)
    scene.clearColor = new BABYLON.Color4 0, 0, 0, 0
    
    camera = new BABYLON.FreeCamera("camera1", new BABYLON.Vector3(0, 0, -1.4), scene)
    camera.setTarget(new BABYLON.Vector3.Zero())
    camera.attachControl(canvas, false)

    light = new BABYLON.HemisphericLight("light1", new BABYLON.Vector3(0, 1, 0), scene)
    light.intensity = 10

    return scene


  scene = createScene()

  upperRow = new BrickRow(scene, 0,0.26)
  lowerRow = new BrickRow(scene, 0,-0.26)

  engine.runRenderLoop ->
    elapsedTime = currentTime() - stateStartTime
    if state == "show-background" && elapsedTime >= backgroundDuration
      state = "show-wall"
      stateStartTime = currentTime()
      frame = new ItemFrame scene, ->
        upperRow.addBrick frame
        frame = new ItemFrame scene, ->
          upperRow.addBrick frame
          frame = new ItemFrame scene, ->
            lowerRow.addBrick frame
            frame = new ItemFrame scene, ->
              lowerRow.addBrick frame
    else if state == "show-wall" && elapsedTime >= wallDuration
      upperRow.clearBricks()
      lowerRow.clearBricks()
      state = "show-background"
      stateStartTime = currentTime()

    scene.render()

  window.addEventListener "resize", ->
    engine.resize()