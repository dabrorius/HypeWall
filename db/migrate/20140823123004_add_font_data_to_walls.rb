class AddFontDataToWalls < ActiveRecord::Migration
  def change
    add_column :walls, :font_color, :string, default: 'light'
    add_column :walls, :font_style, :string, default: 'helvetica'
  end
end
