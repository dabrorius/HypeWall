class AddStatusToImages < ActiveRecord::Migration
  def change
    add_column :images, :status, :string, default: 'pending_approval'
  end
end
