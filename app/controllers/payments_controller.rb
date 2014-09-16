class PaymentsController < ApplicationController
  def buy
    @activation = ActivationCode.create
  end
end
