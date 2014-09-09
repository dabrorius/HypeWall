require 'rails_helper'

describe User do
  context "when user is deleted" do
    let!(:user) { FactoryGirl.create :user }
    let!(:wall) { FactoryGirl.create :wall }

    before { user.walls << wall }

    it "walls belonging to the user are deleted too" do
      expect { user.destroy }.
      to change{ Wall.count }.from(1).to(0)
    end
  end
end