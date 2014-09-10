class AddStatusToImages < ActiveRecord::Migration
  def change
    add_column :images, :status, :string
  end
end
