class ChangeWallIdTypeInBannedUsers < ActiveRecord::Migration
  def change
  	change_column :banned_users, :wall_id, 'integer USING CAST(wall_id AS integer)'
  end
end
