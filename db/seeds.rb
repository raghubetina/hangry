# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

["arjun@hangry.io", "raghu@hangry.io"].each do |admin|
  User.create :email =>  admin,
              :password => "12341234",
              :password_confirmation => "12341234"
end

User.create :email => "team@hangry.io",
            :password => "mechanicalturk",
            :password_confirmation => "mechanicalturk"


