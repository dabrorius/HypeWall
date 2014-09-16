class AddTextToTwitterItem < ActiveRecord::Migration
  def change
    add_column :items, :text, :string
  end
end
