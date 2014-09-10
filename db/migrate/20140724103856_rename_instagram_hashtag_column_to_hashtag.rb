class RenameInstagramHashtagColumnToHashtag < ActiveRecord::Migration
  def change
    rename_column :walls, :instagram_hashtag, :hashtag
  end
end
