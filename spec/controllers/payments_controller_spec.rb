require 'rails_helper'

RSpec.describe PaymentsController, :type => :controller do

  describe "GET buy" do
    it "returns http success" do
      get :buy
      expect(response).to be_success
    end
  end

end
