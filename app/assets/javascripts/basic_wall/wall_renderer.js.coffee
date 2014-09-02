$ ->
  canvas = document.getElementById "renderCanvas"
  engine = new BABYLON.Engine canvas, true    




  createScene = ->
    scene = new BABYLON.Scene(engine)
    scene.clearColor = new BABYLON.Color3 0, 0, 0
    @frames = []

    for position in [0..6]
      frame = new Frame(scene)
      frame.moveToPosition(position - 3)
      @frames.push(frame)

    camera = new BABYLON.FreeCamera("camera1", new BABYLON.Vector3(0, 0, -11), scene)
    camera.setTarget(new BABYLON.Vector3.Zero())
    camera.attachControl(canvas, false)

    light = new BABYLON.HemisphericLight("light1", new BABYLON.Vector3(0, 1, 0), scene)
    light.intensity = 10

    window.setInterval ->
      for frame in frames
        frame.moveToNextPosition()
    , 6000

    mesh = BABYLON.Mesh.CreatePlane("Frame", 10, scene)
    mesh.material = new BABYLON.StandardMaterial("texture1", scene)
    dynamicTexture = new BABYLON.DynamicTexture("dynamic texture", 512, scene, true)
    dynamicTexture.hasAlpha = true
    mesh.material.diffuseTexture = dynamicTexture

    count = 0
    scene.beforeRender = ->
      textureContext = dynamicTexture.getContext()
      size = dynamicTexture.getSize()
      text = count.toString()

      #textureContext.save()
      textureContext.fillStyle = "red"
      textureContext.fillRect(0, 0, size.width, size.height)

      textureContext.font = "bold 120px Calibri"
      textSize = textureContext.measureText(text)
      textureContext.fillStyle = "white"
      textureContext.fillText(text, (size.width - textSize.width) / 2, (size.height - 120) / 2)

      # textureContext.restore()

      # dynamicTexture.update()
      count++
    return scene;

  scene = createScene()

  engine.runRenderLoop ->
    Frame.inFocus.zoom() if Frame.inFocus
    scene.render()

  window.addEventListener "resize", ->
    engine.resize()
