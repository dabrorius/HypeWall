class ActivationCodeMailer < ActionMailer::Base
  default from: "from@example.com"

  def activate_mail(email, activation)
    @email = email
    @activation = activation
    mail(to: email, subject: 'Hypewall activation')
  end
end
