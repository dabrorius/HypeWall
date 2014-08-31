$ ->
  canvas = document.getElementById "renderCanvas"
  engine = new BABYLON.Engine canvas, true
  imageData = [
    "/ultra/high.jpg",
    "/ultra/wide.jpg"
  ]

  @currentImageIndex = 0

  getNextUrl = =>
    url = imageData[@currentImageIndex]
    @currentImageIndex = (@currentImageIndex + 1) % imageData.length
    return url

  zoomCurrent = ->
    for frame in frames
      if frame.position == 0
        step = scene.getLastFrameDuration() / 4000;
        frame.mesh.material.diffuseTexture.uScale -= step
        frame.mesh.material.diffuseTexture.vScale -= step
        frame.mesh.material.diffuseTexture.uOffset -= step

  createScene = ->
    scene = new BABYLON.Scene(engine)

    @frames = []

    for position in [0..6]
      url = getNextUrl()
      frame = new Frame(url,scene)
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
