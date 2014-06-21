class ImagesController < ApplicationController
  def next
    render json: { url: Image.next.url }
  end
end
