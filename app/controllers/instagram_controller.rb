class InstagramController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def new_subscription
  end

  def create_subscription
    Instagram.subscriptions.each do |subscription|
      puts subscription
      Instagram.delete_subscription(id: subscription.id)
    end
    Thread.new do |t|
      Instagram.create_subscription('tag', "#{root_url}instagram/webhook", object_id: params[:tag])
      get_images
      t.exit
    end
    redirect_to :back
  end

  def webhook
    if request.get?
      hub_challenge = params['hub.challenge'.to_sym]
      render text: hub_challenge
    elsif request.post?
      get_images
      render nothing: true
    end
  end

  def get_images
   tag = Instagram.subscriptions.first['object_id']
    images = Instagram.tag_recent_media(tag)
    images.each do |image|
      unless Image.find_by_original_id(image.id).present?
        Image.create(
          original_id: image.id,
          user_id: image.user.id,
          url: image.images.standard_resolution.url)
      end
    end
  end
end