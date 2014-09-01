$ ->
  canvas = document.getElementById "renderCanvas"
  engine = new BABYLON.Engine canvas, true
  imageData = [
    "/ultra/high.jpg",
    "/ultra/wide.jpg",
    "/ultra/1.jpg"
  ]

  @currentImageIndex = 0

  getNextUrl = =>
    url = imageData[@currentImageIndex]
    @currentImageIndex = (@currentImageIndex + 1) % imageData.length
    return url

  zoomCurrent = =>
    for frame in frames
      if frame.position == 0
        elapsedTime = ( (new Date().getTime()) - frame.onPositionSince )
        percentPan = elapsedTime / 6000
        frame.mesh.material.diffuseTexture.uScale = 1 - 0.1 * percentPan
        frame.mesh.material.diffuseTexture.vScale = 1 - 0.1 * percentPan


  createScene = ->
    scene = new BABYLON.Scene(engine)

    @frames = []

    for position in [0..6]
      frame = new Frame(getNextUrl,scene)
      frame.moveToPosition(position - 3)
      @frames.push(frame)

    camera = new BABYLON.FreeCamera("camera1", new BABYLON.Vector3(0, 0, -9), scene)
    camera.setTarget(new BABYLON.Vector3.Zero())
    camera.attachControl(canvas, false)

    light = new BABYLON.HemisphericLight("light1", new BABYLON.Vector3(0, 1, 0), scene)
    light.intensity = 10

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
