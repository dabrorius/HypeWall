class CreateWalls < ActiveRecord::Migration
  def change
    create_table :walls do |t|
      t.string :name
      t.string :instagram_hashtag
      t.text :description

      t.timestamps
    end
  end
end
