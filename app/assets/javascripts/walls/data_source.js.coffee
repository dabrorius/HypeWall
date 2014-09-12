class @DataSource
  @imageData: []

  @currentIndex: 0

  @getNext: =>
    url = @imageData[@currentIndex]
    @currentIndex = (@currentIndex + 1) % @imageData.length
    return url