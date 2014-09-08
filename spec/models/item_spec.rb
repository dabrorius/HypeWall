require 'rails_helper'

describe Item do

  context "when wall does not require item approval" do
    let(:wall) { FactoryGirl.create :wall, require_image_approval: false }
    let(:item) { FactoryGirl.create :item, wall: wall }

    it "sets status to approved" do
      expect(item.status).to eq('approved')
    end
  end

  context "when wall requires item approval" do
    let(:wall) { FactoryGirl.create :wall, require_image_approval: true }

    it "sets status to pending approval" do
      item = Item.create wall_id: wall.id
      expect(item.status).to eq('pending_approval')
    end

    it "allows override of status" do
      item2 = Item.create wall_id: wall.id, status: 'approved'
      expect(item2.status).to eq('approved')
    end
  end


  describe "scope -> approved" do
    let(:pending_item) { FactoryGirl.create :item }
    let(:approved_item) { FactoryGirl.create :item }

    it "shows only approved items" do
      expect(Item.approved).to eq([approved_item])
    end
  end

end
