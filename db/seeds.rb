# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


captain = User.create email: "captain@hypewall.io", 
  password: "password", 
  password_confirmation: "password"

wall = Wall.create name: "ZIP Party",
  description: "Welcome to zip pirate party\n#zipparty\nGet drunk or die!",
  hashtag: "zipparty"

captain.walls << wall

8.times do |i|
  Image.create url: "/ultra/#{i+1}.jpg", 
    likes: rand(20),
    wall: wall
end