require 'rails_helper'

describe User do
  let!(:user) { FactoryGirl.create :user }
  let!(:wall) { FactoryGirl.create :wall }
  context "when wall role exists" do
    let!(:wall_role) { FactoryGirl.create :wall_role, user_id:  user.id, wall_id: wall.id }

    it "wall role is properly removed" do
      expect { wall_role.destroy }.
      to change{ WallRole.count }.from(1).to(0)
    end

    it "user is not deleted when wall role is" do
      expect { wall_role.destroy }.
      to_not change{ User.count }
    end

    it "wall is deleted when wall role is" do
      expect { wall_role.destroy }.
      to_not change{ Wall.count }
    end

  end

  it "walls belonging to the user are deleted too" do
    user.walls << wall
    expect { user.destroy }.
    to change{ Wall.count }.from(1).to(0)
  end
end