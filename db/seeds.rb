require 'faker'

20.times do
  User.create(provider: 'facebook', uid: Faker::Number.number(10),
    name: Faker::Name.first_name,
    oauth_token: Faker::Number.number(20),
    oauth_expires_at: Time.now(),
    email: Faker::Internet.email
    )
end
