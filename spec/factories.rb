require 'faker'

FactoryGirl.define do
  factory :user do
    provider "facebook"
    uid "123456"
    name "Jared Rader"
    oauth_token "123456"
    oauth_expires_at (Time.now + 1.week)
    sequence(:email) { |n| "user-#{n}@gmail.com" }
  end
end

FactoryGirl.define do
  factory :concert do |f|
    f.date Date.new(2014, 5, 24)
    f.venue_id { Faker::Number.digit }
  end
end

FactoryGirl.define do
  factory :venue do |f|
    f.name { Faker::Company.name }
    f.city { Faker::Address.city }
    f.state { Faker::Address.state }
  end
end

FactoryGirl.define do
  factory :concert_song do |f|
    f.concert_id { Faker::Number.digit }
    f.song_id { Faker::Number.digit }
    f.video_identifier { Faker::Code.isbn }
  end
end
