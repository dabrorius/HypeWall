$ ->
  canvas = document.getElementById "renderCanvas"
  engine = new BABYLON.Engine canvas, true

  createScene = ->
    scene = new BABYLON.Scene(engine)

    camera = new BABYLON.FreeCamera("camera1", new BABYLON.Vector3(0, 0, -9), scene)
    camera.setTarget(new BABYLON.Vector3.Zero())
    camera.attachControl(canvas, false)

    light = new BABYLON.HemisphericLight("light1", new BABYLON.Vector3(0, 1, 0), scene)
    light.intensity = 1

    u1 = new Frame("/ultra/1.jpg", scene)
    u1.moveToPosition(-3)
    u2 = new Frame("/ultra/2.jpg", scene)
    u2.moveToPosition(-2)
    u3 = new Frame("/ultra/3.jpg", scene)
    u3.moveToPosition(-1)
    u4 = new Frame("/ultra/4.jpg", scene)
    u4.moveToPosition(0)
    u5 = new Frame("/ultra/5.jpg", scene)
    u5.moveToPosition(1)
    u6 = new Frame("/ultra/6.jpg", scene)
    u6.moveToPosition(2)
    u7 = new Frame("/ultra/7.jpg", scene)
    u7.moveToPosition(3)

    window.setInterval ->
      u1.moveToNextPosition()
      u2.moveToNextPosition()
      u3.moveToNextPosition()
      u4.moveToNextPosition()
      u5.moveToNextPosition()
      u6.moveToNextPosition()
      u7.moveToNextPosition()
    , 6000
    return scene;

  scene = createScene()

  engine.runRenderLoop ->
    scene.render()

  window.addEventListener "resize", ->
    engine.resize()
