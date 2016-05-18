# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create!(name:  "Mr. T",
                  email: "pityer@squad.co")

3.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@squad.co"
  User.create!(name: name,
               email: email)
end

sq1 = Squad.create!(name: "A Team")
sq2 = Squad.create!(name: "B Team")
sq3 = Squad.create!(name: "C Team")

u1.squads = [sq1, sq2, sq3]

u1.save