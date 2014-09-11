class FastspringController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def webhook
    if params['customer'].present?
      user_email = params['customer']['email']
      user = User.find_by_email(user_email)
      user.update_attributes(subscription_level: 'pro')
    end
    render status: 200
  end

end