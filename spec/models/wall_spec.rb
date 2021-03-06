require 'rails_helper'

describe Wall do

  it "removes # from hashtag" do
    wall = FactoryGirl.create(:wall)
    wall.hashtag = "#hashtag"
    wall.save
    expect(wall.hashtag).to eq('hashtag')
  end

  context "when wall has an item" do
    let!(:wall) { FactoryGirl.create :wall }
    let!(:item) { FactoryGirl.create :item, wall: wall }

    it "and the wall is deleted, it removes the associated item too" do
      expect { wall.destroy }.
      to change{ Item.count }.from(1).to(0)
    end
  end

end
