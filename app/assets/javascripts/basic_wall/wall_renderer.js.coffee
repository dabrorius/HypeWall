$ ->
  canvas = document.getElementById "renderCanvas"
  engine = new BABYLON.Engine canvas, true

  zoomCurrent = ->
    for frame in frames
      if frame.position == 0
        step = scene.getLastFrameDuration() / 5000;
        frame.mesh.material.diffuseTexture.uScale -= step
        frame.mesh.material.diffuseTexture.vScale -= step

  createScene = ->
    scene = new BABYLON.Scene(engine)

    @frames = [new Frame("/ultra/1.jpg", scene),
      new Frame("/ultra/2.jpg", scene),
      new Frame("/ultra/3.jpg", scene),
      new Frame("/ultra/4.jpg", scene),
      new Frame("/ultra/5.jpg", scene),
      new Frame("/ultra/6.jpg", scene),
      new Frame("/ultra/7.jpg", scene)
    ]

    camera = new BABYLON.FreeCamera("camera1", new BABYLON.Vector3(0, 0, -9), scene)
    camera.setTarget(new BABYLON.Vector3.Zero())
    camera.attachControl(canvas, false)

    light = new BABYLON.HemisphericLight("light1", new BABYLON.Vector3(0, 1, 0), scene)
    light.intensity = 10

    @frames[0].moveToPosition(-3)
    @frames[1].moveToPosition(-2)
    @frames[2].moveToPosition(-1)
    @frames[3].moveToPosition(0)
    @frames[4].moveToPosition(1)
    @frames[5].moveToPosition(2)
    @frames[6].moveToPosition(3)

    window.setInterval ->
      for frame in frames
        frame.moveToNextPosition()
    , 6000
    return scene;

  scene = createScene()

  engine.runRenderLoop ->
    zoomCurrent()
    scene.render()

  window.addEventListener "resize", ->
    engine.resize()
