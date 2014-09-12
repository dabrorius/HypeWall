$ ->
  canvas = document.getElementById "wall_bricks"
  engine = new BABYLON.Engine canvas, true    
  DataSource.imageData = $("#wall_bricks").attr("data-images").split(',')
  createScene = ->
    scene = new BABYLON.Scene(engine)
    scene.clearColor = new BABYLON.Color4 0, 0, 0, 0
    
    camera = new BABYLON.FreeCamera("camera1", new BABYLON.Vector3(0, 0, -1.4), scene)
    camera.setTarget(new BABYLON.Vector3.Zero())
    camera.attachControl(canvas, false)

    light = new BABYLON.HemisphericLight("light1", new BABYLON.Vector3(0, 1, 0), scene)
    light.intensity = 10

    upperRow = new BrickRow(scene, 0,0.26)
    lowerRow = new BrickRow(scene, 0,-0.26)

    clear = false
    addNewBrick = ->
      if clear
        upperRow.clearBricks()
        lowerRow.clearBricks()
        clear = false
      else
        frame = new ItemFrame scene, ->
          upperRow.addBrick frame
          frame = new ItemFrame scene, ->
            upperRow.addBrick frame
            frame = new ItemFrame scene, ->
              lowerRow.addBrick frame
              frame = new ItemFrame scene, ->
                lowerRow.addBrick frame
        clear = true

    window.setInterval addNewBrick, 6000


    return scene

  scene = createScene()
  engine.runRenderLoop ->
    scene.render()

  window.addEventListener "resize", ->
    engine.resize()