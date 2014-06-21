class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :original_id
      t.string :user_id
      t.string :url
      t.boolean :presented, default: false

      t.timestamps
    end
  end
end
