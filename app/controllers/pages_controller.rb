class PagesController < ApplicationController
  def landing
  end

  def wall
  end

  def frames
    @photos = [Image.next, Image.next, Image.next, Image.next]
    render partial: 'pages/frames'
  end
end
