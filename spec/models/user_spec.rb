require 'rails_helper'

describe User do
  let!(:user) { FactoryGirl.create :user }
  let!(:wall) { FactoryGirl.create :wall }
  context "when wall role exists" do
    let!(:wall_role) { FactoryGirl.create :wall_role, user_id:  user.id, wall_id: wall.id }

    it "wall roles belonging to the user are deleted too" do
      expect { user.destroy }.
      to change{ WallRole.count }.from(1).to(0)
    end
  end


  it "walls belonging to the user are deleted too" do
    user.walls << wall
    expect { user.destroy }.
    to change{ Wall.count }.from(1).to(0)
  end


end