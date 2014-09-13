class @DataSource
  @imageData: []

  @currentIndex: 0

  @initialize: =>
    @imageData = $("#wall_bricks").attr("data-images").split(',')
    websocketHost = $("#wall_bricks").attr("data-websocket-host")
    wallId = $("#wall_bricks").attr("data-wall-id")
    dispatcher = new WebSocketRails(websocketHost)
    channel = dispatcher.subscribe('wall_' + wallId)
    channel.bind 'new', (url) =>
      console.log "New image " + url
      @imageData.splice(@currentIndex, 0, url)

  @getNext: =>
    url = @imageData[@currentIndex]
    @currentIndex = (@currentIndex + 1) % @imageData.length
    return url

  @removeCurrent: (position) =>
    @imageData.splice(@currentIndex-1, 1)
    console.log @imageData