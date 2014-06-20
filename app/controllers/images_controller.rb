class ImagesController < ApplicationController
  def next
    render json: { url: "/stock/#{rand(1..8)}.jpg" }
  end
end
