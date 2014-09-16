class AddIsActiveToWalls < ActiveRecord::Migration
  def up
    add_column :walls, :is_active, :boolean, default: false
  end

  def down
    remove_column :walls, :is_active, :boolean
  end
end
