class InstagramController < ApplicationController

  def webhook
    hub_challenge = params['hub.challenge'.to_sym]
    render text: hub_challenge
  end
end