class @ItemFrame
  textureSize: 512
  border: 5
  borderColor: "#FFFFFF"
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
    img.src = "/ultra/wide.jpg"
    
    img.onload = =>
      @aspectRatio = img.width / img.height
      @mesh.scaling.x = @aspectRatio

      context = @texture.getContext()
      context.save()
      context.fillStyle = @borderColor
      context.fillRect(0,0,@textureSize * @aspectRatio, @textureSize)
      context.drawImage( img, 0, 0, 
        img.width, img.height, @border, @border, 
        (@textureSize - @border * 2), (@textureSize - @border * 2)
      )

      username = "dabrorius"
      context.font = "20px helvetica"
      textSize = context.measureText(username)
      textX = @textureSize - textSize.width
      textY = @textureSize - 20
      console.log(textSize)
      context.fillText(username, textX, textY)

      context.restore()
      @texture.update()
