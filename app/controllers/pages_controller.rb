class PagesController < ApplicationController
  def landing
  end

  def wall
    @photos = ['/stock/1.jpg', '/stock/2.jpg', '/stock/3.jpg', '/stock/4.jpg', '/stock/5.jpg', '/stock/6.jpg', '/stock/7.jpg', '/stock/8.jpg', '/stock/9.jpg']
  end

  def frames
    @photos = [Image.next, Image.next, Image.next, Image.next]
    render partial: 'pages/frames'
  end
end
