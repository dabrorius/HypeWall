class FastspringController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def webhook
    if params['customer'].present?
      user_email = params['customer']['email']


    end
    render status: 200
  end
end