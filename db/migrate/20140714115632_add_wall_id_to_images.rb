class AddWallIdToImages < ActiveRecord::Migration
  def change
    add_reference :images, :wall, index: true
  end
end
