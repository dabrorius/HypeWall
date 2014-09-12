class @ItemFrame
  textureSize: 512
  border: 1
  borderColor: "#FFFFFF"
  font: "40px helvetica"
  textPadding: 20
  aspectRatio: 1
  height: 0.5
  width: 0.5

  constructor: (scene, onLoad) ->
    @onLoad = onLoad
    @scene = scene
    @mesh = BABYLON.Mesh.CreatePlane("Frame", @height, scene)
    @mesh.material = new BABYLON.StandardMaterial "FrameMaterial", scene

    @texture = new BABYLON.DynamicTexture "FrameTexture", @textureSize, scene, true
    @mesh.material.diffuseTexture = @texture
    @loadImage()

  loadImage: ->
    img = new Image()
    img.src = DataSource.getNext()
    
    img.onload = =>
      @aspectRatio = img.width / img.height
      @width = @width * @aspectRatio
      @mesh.scaling.x = @aspectRatio
      @updateRender(img, 0)
      @onLoad()

  updateRender: (img, zoom = 0) ->
    context = @texture.getContext()
    context.fillStyle = @borderColor
    context.fillRect(0,0,@textureSize, @textureSize)
    context.drawImage( img, zoom, zoom/@aspectRatio, 
      img.width - zoom, img.height - zoom / @aspectRatio, @border/@aspectRatio, @border, 
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

