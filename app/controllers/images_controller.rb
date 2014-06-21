class ImagesController < ApplicationController
  def next
    render json: { url: "/stock/#{rand(1..9)}.jpg" }
  end
end
