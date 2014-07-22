class AddBgStyleToWall < ActiveRecord::Migration
  def change
    add_column :walls, :background_style, :string, default: 'center'
  end
end
