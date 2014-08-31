class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :original_id
      t.string :user_id
      t.string :url
      t.integer :likes, default: 0
      t.integer :wall_id
      t.string :status
      t.string :type

      t.timestamps
    end
  end
end
