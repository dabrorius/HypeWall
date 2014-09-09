class @DataSource
  @imageData: [
    "/ultra/high.jpg",
    "/ultra/wide.jpg",
    "/ultra/1.jpg",
    "/ultra/2.jpg",
    "/ultra/3.jpg",
    "/ultra/4.jpg",
    "/ultra/5.jpg"
  ]

  @currentIndex: 0

  @getNext: =>
    url = @imageData[@currentIndex]
    @currentIndex = (@currentIndex + 1) % @imageData.length
    return url