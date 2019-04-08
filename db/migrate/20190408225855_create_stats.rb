class CreateStats < ActiveRecord::Migration[5.2]
  def change
    create_table :stats do |t|
      t.integer :deliveries_count, null: false, default: 0
      t.timestamps
    end
  end
end
