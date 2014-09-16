class CreateActivationCodes < ActiveRecord::Migration
  def change
    create_table :activation_codes do |t|
      t.string :code, unique: true
      t.references :wall, index: true
      t.timestamp :used_at
      t.integer :valid_for, default: 1440

      t.timestamps
    end
  end
end
