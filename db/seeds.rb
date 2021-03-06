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

#10.times do
#  follower, followee = users.sample(2)
#  followee.followers << follower
#end

member = User.new(
  name:     'Rani',
  email:    'ran@bitsofgold.co.il',
  password: 'helloworld'
)
member.skip_confirmation!
member.save!

5.times do
  user = users.sample
  UserConnection.create(follower: user, followee: member)
  member.mentions << user
end

puts "Seed finished"
puts "#{User.count} users created"
