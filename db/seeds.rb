# Create Users
15.times do
  user = User.create(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

10.times do
  follower, followee = users.sample(2)
  followee.followers << follower
end

member = User.new(
  name:     'Rani',
  email:    'ran@bitsofgold.co.il',
  password: 'helloworld'
)
member.skip_confirmation!
member.save!

followersAndMentioners = users.sample(5)
member.followers << followersAndMentioners
member.mentions << followersAndMentioners

puts "Seed finished"
puts "#{User.count} users created"
