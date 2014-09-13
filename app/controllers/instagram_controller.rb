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
    wall.new_items.each do |item|
      push_to_item_control item
      push_to_wall item if item.status == 'approved'
    end
  end
end
