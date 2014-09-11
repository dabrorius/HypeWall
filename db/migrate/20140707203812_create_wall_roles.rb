class CreateWallRoles < ActiveRecord::Migration
  def change
    create_table :wall_roles do |t|
      t.references :user, index: true
      t.references :wall, index: true

      t.timestamps
    end
  end
end
