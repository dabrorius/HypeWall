class @ItemFrame
  textureSize: 512
  border: 10
  borderColor: "#FFFFFF"
  font: "40px helvetica"
  textPadding: 20
  aspectRatio: 1

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
      @aspectRatio = img.width / img.height
      @mesh.scaling.x = @aspectRatio

      context = @texture.getContext()
      context.fillStyle = @borderColor
      context.fillRect(0,0,@textureSize, @textureSize)
      context.drawImage( img, 0, 0, 
        img.width, img.height, @border/@aspectRatio, @border, 
        (@textureSize - @border/@aspectRatio * 2), (@textureSize - @border * 2)
      )

      username = "dabrorius"
      context.save()
      context.scale(1/@aspectRatio, 1);
      context.font = @font
      textSize = context.measureText(username)
      textX = @textureSize * @aspectRatio - textSize.width - @textPadding
      textY = @textureSize - @textPadding
      context.fillText(username, textX, textY)
      context.restore()

      @texture.update()
