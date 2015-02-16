require 'csv'

["arjun@hangry.io", "raghu@hangry.io"].each do |admin|
  User.create :email =>  admin,
              :password => "brunchtime",
              :password_confirmation => "brunchtime"
end

User.create :email => "team@hangry.io",
            :password => "mechanicalturk",
            :password_confirmation => "mechanicalturk"

csv_text = File.read(Rails.root.join("lib", "seeds", "restaurants.csv"))
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  Restaurant.create!(row.to_hash)
end
