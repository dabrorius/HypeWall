class CreateBannedUsers < ActiveRecord::Migration
  def change
    create_table :banned_users do |t|
    	t.string :user_id
    	t.string :wall_id
    	t.string :type

      t.timestamps
    end
  end
end
