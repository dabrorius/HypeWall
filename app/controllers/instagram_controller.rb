class InstagramController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def webhook
    if request.get?
      hub_challenge = params['hub.challenge'.to_sym]
      render text: hub_challenge
    elsif request.post?
      get_instagram_images
      render nothing: true
    end
  end

  def get_instagram_images
    hashtag = params['_json'][0]['object_id']
    wall = Wall.find_by_hashtag(hashtag)
    new_images = wall.get_instagram_images
    new_images.each do |image|
      push_to_image_control image
    end
  end
end