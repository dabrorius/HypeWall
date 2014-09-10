$ ->
  canvas = document.getElementById "wall_bricks"
  engine = new BABYLON.Engine canvas, true    

  createScene = ->
    scene = new BABYLON.Scene(engine)
    scene.clearColor = new BABYLON.Color3 0, 0, 0
    
    camera = new BABYLON.FreeCamera("camera1", new BABYLON.Vector3(0, 0, -1.18), scene)
    camera.setTarget(new BABYLON.Vector3.Zero())
    camera.attachControl(canvas, false)

    light = new BABYLON.HemisphericLight("light1", new BABYLON.Vector3(0, 1, 0), scene)
    light.intensity = 10

    currentRow = 0
    rows = [new BrickRow(scene, 0,0.25), new BrickRow(scene, 0.1,-0.25)]

    addedBricks = 0
    addNewBrick = ->
      if addedBricks >= 14
        for row in rows
          row.clearBricks()
          addedBricks = 0
      else
        row = rows[currentRow]
        frame = new ItemFrame scene, ->
          row.addBrick frame
        currentRow = (currentRow + 1) % rows.length
        addedBricks += 1

    window.setInterval addNewBrick, 3000


    return scene

  scene = createScene()
  engine.runRenderLoop ->
    scene.render()

  window.addEventListener "resize", ->
    engine.resize()