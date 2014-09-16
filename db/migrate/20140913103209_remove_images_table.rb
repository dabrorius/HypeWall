class RemoveImagesTable < ActiveRecord::Migration
  def up
    drop_table :images
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
