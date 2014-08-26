require 'rails_helper'

describe Wall do

  it "removes # from hashtag" do
    wall = FactoryGirl.create(:wall)
    wall.hashtag = "#hashtag"
    wall.save
    expect(wall.hashtag).to eq('hashtag')
  end

end
