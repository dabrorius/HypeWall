class PagesController < ApplicationController
  def landing
  end

  def wall
  end

  def frames
    frames_count = 3
    last_frame = Rails.cache.fetch('last_frame') || 0
    @current_frame = (last_frame + 1) % frames_count;
    Rails.cache.write('last_frame', @current_frame)

    @photos = [Image.next, Image.next, Image.next, Image.next]
    render partial: 'pages/frames'
  end
end
