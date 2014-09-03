class @ItemFrame
  textureSize: 512

  constructor: (scene) ->
    @scene = scene
    @mesh = BABYLON.Mesh.CreatePlane("Frame", 5, scene)
    @mesh.material = new BABYLON.StandardMaterial "FrameMaterial", scene

    @texture = new BABYLON.DynamicTexture "FrameTexture", @textureSize, scene, true
    @mesh.material.diffuseTexture = @texture
    @loadImage()

  loadImage: ->
    img = new Image()
    img.src = "/ultra/1.jpg"

    img.onload = =>
      context = @texture.getContext()
      context.save()
      context.drawImage(img, 0,0, img.width, img.height, 0, 0, @textureSize, @textureSize)
      context.restore()
      @texture.update()
