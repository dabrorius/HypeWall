# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

captain = User.create email: "captain@hypewall.io",
  password: "password",
  password_confirmation: "password",
  subscription_level: "pro",
  is_admin: true

free_user = User.create email: "freeuser@hypewall.io",
  password: "password",
  password_confirmation: "password",
  subscription_level: "free",
  is_admin: false

wall = Wall.create name: "ZIP Party",
  description: "Welcome to zip pirate party\n#zipparty\nGet drunk or die!",
  hashtag: "zipparty"

user_wall = Wall.create name: "User wall",
  description: "Welcome to free users wall!",
  hashtag: "free"

captain.walls << wall
free_user.walls << user_wall

50.times do |i|
  image_count = (i % 8) + 1
  Item.create url: "/ultra/#{image_count}.jpg",
    likes: rand(20),
    wall: wall
end

8.times do |i|
  Item.create url: "/ultra/#{i+1}.jpg",
    likes: rand(20),
    wall: user_wall
end
