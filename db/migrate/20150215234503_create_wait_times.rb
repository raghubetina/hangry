class CreateWaitTimes < ActiveRecord::Migration
  def change
    create_table :wait_times do |t|
      t.belongs_to :restaurant, index: true
      t.integer :party_size
      t.integer :minutes
      t.datetime :checked_at

      t.timestamps null: false
    end
    add_foreign_key :wait_times, :restaurants
  end
end
