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
      @imageData.splice(@currentIndex, 0, newItem)

  @getNext: =>
    url = @imageData[@currentIndex].url
    @currentIndex = (@currentIndex + 1) % @imageData.length
    return url

  @removeCurrent: =>
    @imageData.splice(@currentIndex-1, 1)
