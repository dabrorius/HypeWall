class @DataSource
  @imageData: []

  @currentIndex: 0

  @initialize: =>
    @imageData = JSON.parse $("#wall_bricks").attr("data-images")

    websocketHost = $("#wall_bricks").attr("data-websocket-host")
    wallId = $("#wall_bricks").attr("data-wall-id")
    dispatcher = new WebSocketRails(websocketHost)
    channel = dispatcher.subscribe('wall_' + wallId)
    
    channel.bind 'new', (newItemJson) =>
      console.log "New image: " + newItemJson
      newItem = JSON.parse(newItemJson)
      @add newItem

    channel.bind 'remove', (itemId) =>
      console.log "Remove image: " + itemId
      @remove itemId

  @add: (newItem) =>
    duplicate = false
    for item in @imageData
      if item.id == newItem.id
        duplicate = true

    if duplicate
      console.log "Duplicate image. Ignored"
    else
      @imageData.splice(@currentIndex, 0, newItem)

  @getNext: =>
    url = @imageData[@currentIndex].url
    @currentIndex = (@currentIndex + 1) % @imageData.length
    return url

  @removeCurrent: =>
    @imageData.splice(@currentIndex-1, 1)

  @remove: (id) =>
    console.log "Remove image #{id}"
    i = @imageData.length
    while i--
      image = @imageData[i]
      if image.id == id
        @imageData.splice(i,1)
