class @DataSource
  @imageData: [
    "/ultra/high.jpg",
    "/ultra/1.jpg",
    "/ultra/2.jpg",
    "/ultra/3.jpg",
    "/ultra/4.jpg",
    "/ultra/5.jpg",
    "/ultra/6.jpg",
    "/ultra/7.jpg",
    "/ultra/8.jpg",
  ]

  @currentIndex: 0

  @getNext: =>
    url = @imageData[@currentIndex]
    @currentIndex = (@currentIndex + 1) % @imageData.length
    return url