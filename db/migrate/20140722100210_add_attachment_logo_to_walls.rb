class AddAttachmentLogoToWalls < ActiveRecord::Migration
  def self.up
    change_table :walls do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :walls, :logo
  end
end
