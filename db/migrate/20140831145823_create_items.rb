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
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.datetime :attachment_updated_at
      t.timestamps
    end
  end
end
