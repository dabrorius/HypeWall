class AddSubscriptionLevelToUser < ActiveRecord::Migration
  def change
    add_column :users, :subscription_level, :string, default: 'free'

    add_index :users, :subscription_level
  end
end
