class AddBackgroundColorToWall < ActiveRecord::Migration
  def change
    add_column :walls, :background_color, :string, default: '#000000'
  end
end
