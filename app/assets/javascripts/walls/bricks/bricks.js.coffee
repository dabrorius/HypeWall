$ ->
  canvas = document.getElementById "wall_bricks"
  engine = new BABYLON.Engine canvas, true    

  createScene = ->
    scene = new BABYLON.Scene(engine)
    scene.clearColor = new BABYLON.Color3 0, 1, 1
    
    camera = new BABYLON.FreeCamera("camera1", new BABYLON.Vector3(0, 0, -10), scene)
    camera.setTarget(new BABYLON.Vector3.Zero())
    camera.attachControl(canvas, false)

    light = new BABYLON.HemisphericLight("light1", new BABYLON.Vector3(0, 1, 0), scene)
    light.intensity = 10

    row1 = new BrickRow(scene, 0,0)

    frame1 = new ItemFrame scene, ->
      row1.addRight frame1
    
    window.setInterval ->
      frame1 = new ItemFrame scene, ->
        console.log "add right"
        row1.addRight frame1
    , 3000

    return scene

  scene = createScene()
  engine.runRenderLoop ->
    scene.render()

  window.addEventListener "resize", ->
    engine.resize()