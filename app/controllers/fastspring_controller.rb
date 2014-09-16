class FastspringController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def webhook
    if params['customer'].present?
      user_email = params['customer']['email']
      activation_code = ActivationCode.create
      if activation_code
        ActivationCodeMailer.activate_mail(user_email, activation_code).deliver
      end
    end
    render nothing: true
  end
end