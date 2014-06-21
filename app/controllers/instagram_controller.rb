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
      Instagram.create_subscription('tag', "http://59fc4634.ngrok.com/instagram/webhook", object_id: params[:tag])
      t.exit
    end
    redirect_to :back
  end

  def webhook
    if request.get?
      hub_challenge = params['hub.challenge'.to_sym]
      render text: hub_challenge
    elsif request.post?
    end
  end
end