class AddSlugToWalls < ActiveRecord::Migration
  def up
    add_column :walls, :slug, :string
    add_index :walls, :slug, unique: true

    Wall.all.each do |wall|
      wall.save
    end
  end

  def down
    remove_index :walls, :slug
    remove_column :walls, :slug
  end
end
