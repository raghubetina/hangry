class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :yelp_url
      t.time :opens_at, :default => Time.parse("10:00am")
      t.time :closes_at, :default => Time.parse("2:00pm")

      t.timestamps null: false
    end
  end
end
