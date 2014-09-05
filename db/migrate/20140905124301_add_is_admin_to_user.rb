class AddIsAdminToUser < ActiveRecord::Migration
  def up
  	add_column :users, :is_admin, :boolean  	
  end

  def down
  	remove_column :users, :is_admin, :boolean
  end
end
