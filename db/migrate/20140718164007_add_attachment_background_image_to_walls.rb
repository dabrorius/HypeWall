class AddAttachmentBackgroundImageToWalls < ActiveRecord::Migration
  def self.up
    change_table :walls do |t|
      t.attachment :background_image
    end
  end

  def self.down
    remove_attachment :walls, :background_image
  end
end
