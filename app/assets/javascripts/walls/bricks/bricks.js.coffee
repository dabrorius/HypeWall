$ ->
  canvas = document.getElementById "wall_bricks"
  engine = new BABYLON.Engine canvas, true    

  createScene = ->
    scene = new BABYLON.Scene(engine)
    scene.clearColor = new BABYLON.Color3 0, 1, 1
    
    camera = new BABYLON.FreeCamera("camera1", new BABYLON.Vector3(0, 0, 0), scene)
    camera.setTarget(new BABYLON.Vector3.Zero())
    camera.attachControl(canvas, false)

    light = new BABYLON.HemisphericLight("light1", new BABYLON.Vector3(0, 1, 0), scene)
    light.intensity = 10
    return scene

  scene = createScene()
  engine.runRenderLoop ->
    scene.render()

  window.addEventListener "resize", ->
    engine.resize()