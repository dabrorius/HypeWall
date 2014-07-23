require 'rails_helper'

describe Image do

  context "when wall does not require image approval" do
    let(:wall) { FactoryGirl.create :wall, require_image_approval: false }
    let(:image) { FactoryGirl.create :image, wall: wall }

    it "sets status to pending approval" do
      expect(image.status).to eq('approved')
    end
  end

  context "when wall requires image approval" do
    let(:wall) { FactoryGirl.create :wall, require_image_approval: true }

    it "sets status to pending approval" do
      image = Image.create wall_id: wall.id
      expect(image.status).to eq('pending_approval')
    end

    it "allows override of status" do
      image2 = Image.create wall_id: wall.id, status: 'approved'
      expect(image2.status).to eq('approved')
    end
  end


  describe "scope -> approved" do
    let(:pending_image) { FactoryGirl.create :image }
    let(:approved_image) { FactoryGirl.create :image }

    it "shows only approved images" do
      expect(Image.approved).to eq([approved_image])
    end
  end

end
