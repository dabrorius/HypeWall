class AddRequireImageApprovalToWall < ActiveRecord::Migration
  def change
    add_column :walls, :require_image_approval, :boolean, default: false
  end
end
